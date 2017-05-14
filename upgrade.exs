defmodule Ressipy.UpgradeCallbacks do
  import Gatling.Bash

  def before_mix_digest(env) do
    assets_path = Path.join([env.build_dir, "assets"])
    bash("npm", ~w[install], cd: assets_path)
    bash("npm", ~w[run deploy], cd: assets_path)
  end

  def before_upgrade_service(env) do
    bash("mix", ~w[ecto.migrate], cd: env.build_dir)
  end
end
