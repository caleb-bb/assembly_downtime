defmodule AssemblyDowntime.Downtimes do
  @moduledoc """
  The Downtimes context.
  """

  import Ecto.Query, warn: false
  alias AssemblyDowntime.Repo

  alias AssemblyDowntime.Downtimes.Downtime

  @doc """
  Returns the list of downtimes.

  ## Examples

      iex> list_downtimes()
      [%Downtime{}, ...]

  """
  def list_downtimes do
    Repo.all(Downtime)
  end

  @doc """
  Gets a single downtime.

  Raises `Ecto.NoResultsError` if the Downtime does not exist.

  ## Examples

      iex> get_downtime!(123)
      %Downtime{}

      iex> get_downtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_downtime!(id), do: Repo.get!(Downtime, id)

  @doc """
  Creates a downtime.

  ## Examples

      iex> create_downtime(%{field: value})
      {:ok, %Downtime{}}

      iex> create_downtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_downtime(attrs \\ %{}) do
    %Downtime{}
    |> Downtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a downtime.

  ## Examples

      iex> update_downtime(downtime, %{field: new_value})
      {:ok, %Downtime{}}

      iex> update_downtime(downtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_downtime(%Downtime{} = downtime, attrs) do
    downtime
    |> Downtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a downtime.

  ## Examples

      iex> delete_downtime(downtime)
      {:ok, %Downtime{}}

      iex> delete_downtime(downtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_downtime(%Downtime{} = downtime) do
    Repo.delete(downtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking downtime changes.

  ## Examples

      iex> change_downtime(downtime)
      %Ecto.Changeset{data: %Downtime{}}

  """
  def change_downtime(%Downtime{} = downtime, attrs \\ %{}) do
    Downtime.changeset(downtime, attrs)
  end
end
