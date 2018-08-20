defmodule EctoRedundancyIssue do
  use Application

  def start(_type, _args) do
    children = [RedundancyRepo]

    Supervisor.start_link(children, strategy: :one_for_one, name: EctoRedundancyIssue.Supervisor)
  end
end
