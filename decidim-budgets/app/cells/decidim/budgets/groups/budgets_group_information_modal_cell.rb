# frozen_string_literal: true

module Decidim
  module Budgets
    module Groups
      # This cell renders the Budgets Group "More information" modal dialog
      class BudgetsGroupInformationModalCell < BudgetsGroupHeaderCell
        def group_component
          component.parent
        end

        def list_heading
          translated_attribute(current_settings.list_heading).presence || translated_attribute(settings.list_heading)
        end

        def group_name
          translated_attribute(group_component.name)
        end

        def discardable
          @discardable ||= if should_discard_to_vote?
                             workflow_instance.discardable
                           else
                             []
                           end
        end

        def order_path_for(component)
          ::Decidim::EngineRouter.main_proxy(component).order_path(return_path: request.path)
        end

        def should_discard_to_vote?
          limit_reached? && workflow_instance.vote_allowed?(component, false)
        end
      end
    end
  end
end