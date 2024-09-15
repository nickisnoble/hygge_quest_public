class AddSlugToGuilds < ActiveRecord::Migration[7.1]
  def change
    add_column :guilds, :slug, :string
    add_index :guilds, :slug, unique: true

    reversible do |dir|
      dir.up do
        say_with_time "Updating guild slugs" do
          Guild.find_each do |guild|
            next if guild.slug.present? && Guild.exists?(slug: guild.name.parameterize)

            begin
              guild.update_column(:slug, guild.name.parameterize)
            rescue => e
              say "Error updating guild #{guild.name}: #{e.message}"
            end
          end
        end
      end
    end
  end
end
