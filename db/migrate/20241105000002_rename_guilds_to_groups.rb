class RenameGuildsToGroups < ActiveRecord::Migration[7.1]
  def change
    rename_table :guilds, :groups
    rename_column :guests, :guild_id, :group_id

    # Remove columns no longer needed
    remove_column :groups, :secret, :boolean
    remove_column :groups, :slug, :string

    # Update Active Storage attachments to reference the new model name
    if table_exists?(:active_storage_attachments)
      execute <<-SQL
        UPDATE active_storage_attachments
        SET record_type = 'Group'
        WHERE record_type = 'Guild'
      SQL
    end
  end
end
