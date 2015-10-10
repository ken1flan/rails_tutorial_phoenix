defmodule RailsTutorialPhoenix.Micropost do
  use RailsTutorialPhoenix.Web, :model

  schema "microposts" do
    field :content, :string
    field :user_id, :integer

    timestamps
  end

  @required_fields ~w(content user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:content, max: 140)
  end
end
