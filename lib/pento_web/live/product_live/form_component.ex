defmodule PentoWeb.ProductLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.Catalog

  @resource_path "priv/static/images";

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:prod_image,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1,
       auto_upload: true,
       progress: &handle_progress/3
     )}
  end

  # defp ext(entry) do
  #   [ext | _] = MIME.extensions(entry.client_type)
  #   ext
  # end

  defp handle_progress(:prod_image, entry, socket) do
    # IO.inspect(entry)
    :timer.sleep(200)

    if entry.done? do
      file_path = consume_uploaded_entry(socket, entry, &upload_static_file(&1, socket))

      # file_path =
      #   consume_uploaded_entry(socket, entry, fn %{path: path} ->
      #     dest = Path.join(Application.app_dir(:pento, "priv/static/images"), Path.basename(path))
      #     File.cp!(path, dest)
      #     {:ok, Routes.static_path(socket, "/images/#{Path.basename(dest)}")}
      # end)

      socket =
        socket
        |> put_flash(:info, "File #{entry.client_name} uploaded")
        |> assign(:image_upload, file_path)

      IO.inspect(socket.assigns)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  defp upload_static_file(%{path: path}, socket) do
    dest = Path.join(Application.app_dir(:pento, @resource_path), Path.basename(path))
    File.cp!(path, dest)
    {:ok, Routes.static_path(socket, "/images/#{Path.basename(dest)}")}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    case Catalog.update_product(
           socket.assigns.product,
           Map.put(product_params, "image_upload", socket.assigns.image_upload)
         ) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(changeset: changeset)
         |> put_flash(:error, "Product cannot be updated! Check error bellow")}
    end
  end

  defp save_product(socket, :new, product_params) do
    case Catalog.create_product(
           Map.put(product_params, "image_upload", socket.assigns.image_upload)
         ) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(changeset: changeset)
         |> put_flash(:error, "Product cannot be created! Check error bellow")}
    end
  end
end
