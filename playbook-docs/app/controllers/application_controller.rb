# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper Playbook::PbDocHelper
  append_view_path Playbook::Engine.root + "app/pb_kits"
end