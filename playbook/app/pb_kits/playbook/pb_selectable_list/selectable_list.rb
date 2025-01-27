# frozen_string_literal: true

module Playbook
  module PbSelectableList
    class SelectableList < Playbook::KitBase
      prop :variant, type: Playbook::Props::Enum,
                     values: %w[radio checkbox],
                     default: "checkbox"

      prop :text, type: Playbook::Props::String

      prop :items, type: Playbook::Props::Array,
                   default: []

      def classname
        generate_classname("pb_selectable_list_kit")
      end
    end
  end
end
