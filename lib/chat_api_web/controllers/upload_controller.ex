defmodule ChatApiWeb.UploadController do
  use ChatApiWeb, :controller
  alias ChatApi.Uploads.Upload

  def create(conn, %{"upload" => upload_params = upload_params}) do
    file_uuid = UUID.uuid4(:hex)
    filename = upload_params.filename
    unique_filename = "#{file_uuid}-#{filename}"
    {:ok, image_binary} = File.read(upload_params.path)
    bucket_name = System.get_env("BUCKET_NAME")

    file =
      ExAws.S3.put_object(bucket_name, unique_filename, image_binary)
      |> ExAws.request!()

    # build the image url and add to the params to be stored
    updated_params =
      upload_params
      |> Map.update(file, upload_params, fn _value ->
        "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{unique_filename}"
      end)

    changeset = Upload.changeset(%Upload{}, updated_params)


    case Repo.insert!(changeset) do
      {:ok, upload} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.upload_path(conn, :show, upload))
        |> render("show.json", upload: upload)

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
