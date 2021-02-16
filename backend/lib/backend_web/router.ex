defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackendWeb do
    pipe_through :api

    get "/folders/roots", FolderController, :roots
    get "/folders/children", FolderController, :children
    post "/folders/add_child", FolderController, :add_child
    get "/folders/search", FolderController, :search
    resources "/folders", FolderController, except: [:index, :create]
  end
end
