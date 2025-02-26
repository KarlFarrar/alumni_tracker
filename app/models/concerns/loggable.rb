module Loggable
  extend ActiveSupport::Concern

    included do
      after_create  :log_create
      after_update  :log_update
      after_destroy :log_destroy
    end

  private

    def log_create
      create_log_entry("created", saved_changes)
    end

    def log_update
      create_log_entry("updated", saved_changes)
    end

    def log_destroy
      create_log_entry("deleted", attributes)
    end

    def create_log_entry(action, changes)
      ChangeLog.create!(
        user: "System", # Temporarily hardcoded until user tracking is ready
        action: action,
        record_type: self.class.name,
        record_id: id,
        change_details: changes.to_json
      )
    end
end
