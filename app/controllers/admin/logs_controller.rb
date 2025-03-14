class Admin::LogsController < ApplicationController
    layout 'admin'
    
    def index
      @logs = ChangeLog.all.order(created_at: :desc)
    end
  end