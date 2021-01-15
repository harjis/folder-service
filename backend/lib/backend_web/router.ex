defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackendWeb do
    pipe_through :api

    resources "/folders", FolderController, except: [:create]
    post "/folders/add_child", FolderController, :add_child
  end
end
