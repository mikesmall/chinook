class AddRankingToAlbum < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :ranking, :integer
    # Adds a column to the ALBUMS table.
    # The column's name is RANKING.
    # The column's type is INTEGER. 
  end
end
