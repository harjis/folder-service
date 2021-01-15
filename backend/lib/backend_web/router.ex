defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackendWeb do
    pipe_through :api

    get "/folders/roots", FolderController, :roots
    resources "/folders", FolderController, except: [:index, :create]
    post "/folders/add_child", FolderController, :add_child
  end
end
