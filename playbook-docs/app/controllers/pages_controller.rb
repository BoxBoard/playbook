# frozen_string_literal: true

require_relative "application_controller"

class PagesController < ApplicationController
  layout "layouts/playbook/application"

  before_action :set_kit, only: %i[kit_show_rails kit_show_react]
  before_action :ensure_kit_type_exists, only: %i[kit_show_rails kit_show_react]
  before_action :set_category, only: %i[kit_category_show_rails kit_category_show_react]
  before_action :delete_dark_mode_cookie, only: %i[home getting_started]

  def delete_dark_mode_cookie
    cookies.delete :dark_mode
  end

  def disable_dark_mode
    cookies[:dark_mode] = {
      value: "false",
    }
    redirect_back(fallback_location: root_path)
  end

  def enable_dark_mode
    cookies[:dark_mode] = {
      value: "true",
    }
    redirect_back(fallback_location: root_path)
  end

  def getting_started; end

  def grid
    render layout: "layouts/playbook/grid"
  end

  def home; end

  def kits
    params[:type] ||= "react"
    @type = params[:type]
    render layout: "layouts/playbook/kits"
  end

  def kit_category_show_rails
    params[:type] ||= "rails"
    @type = params[:type]
    render template: "playbook/pages/kit_category_show", layout: "layouts/playbook/kits"
  end

  def kit_category_show_react
    render template: "playbook/pages/kit_category_show", layout: "layouts/playbook/kits"
  end

  def kit_show_rails
    render "playbook/pages/kit_show", layout: "layouts/playbook/kits"
  end

  def kit_show_react
    render template: "playbook/pages/kit_show", layout: "layouts/playbook/kits"
  end

  def principles; end

  def visual_guidelines; end

private

  def set_category
    categories = MENU["kits"].map { |link| link.first.first if link.is_a?(Hash) }.compact
    @category = params[:name]
    if categories.flatten.include?(@category)
      @category_kits = MENU["kits"].map { |link| link.first.last if link.is_a?(Hash) && link.first.first == @category }.compact.flatten
      @kits = params[:name]
    else
      redirect_to root_path, flash: { error: "That kit does not exist" }
    end
  end

  def set_kit
    menu = MENU["kits"].map { |link| link.is_a?(Hash) ? link.first.last : link }
    if menu.flatten.include?(params[:name])
      @kit = params[:name]
    else
      redirect_to root_path, flash: { error: "That kit does not exist" }
    end
  end

  def ensure_kit_type_exists
    # TODO: unsure why we cannot simply use the helpers that are included in ApplicationController - fix this
    is_rails_kit = action_name == "kit_show_rails"
    files = is_rails_kit ? File.join("**", "*.erb") : File.join("**", "*.jsx")
    kit_files = Dir.glob(files, base: "#{Playbook::Engine.root}/app/pb_kits/playbook/pb_#{@kit}/docs").present?
    if !kit_files.present?
      redirect_to action: is_rails_kit ? "kit_show_react" : "kit_show_rails"
    end
  end
end