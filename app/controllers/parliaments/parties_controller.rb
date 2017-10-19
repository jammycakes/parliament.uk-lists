module Parliaments
  class PartiesController < ApplicationController
    before_action :data_check, :build_request

    ROUTE_MAP = {
      index: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliament_parties.set_url_params({ parliament_id: params[:parliament_id] }) },
    }.freeze

    def index
      @parliament, @parties = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
        @request,
        Parliament::Utils::Helpers::RequestHelper.namespace_uri_schema_path('ParliamentPeriod'),
        Parliament::Utils::Helpers::RequestHelper.namespace_uri_schema_path('Party')
      )

      @parliament = @parliament.first
      @parties = @parties.multi_direction_sort({ member_count: :desc, name: :asc })
    end
  end
end
