module DungeonMaster::Cerberus
  extend ActiveSupport::Concern

  included do
    layout "dungeon_master"
    before_action :require_user!
    before_action :require_dm!
  end
end