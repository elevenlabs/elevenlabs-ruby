# frozen_string_literal: true

# Agent tools as code: a chained builder for webhook, client and system tools, on top of tools.create /
# tools.update.
#
# Requires the generated SDK to be loaded first (require 'elevenlabs'). Hand-written (see .fernignore):
# the builder is a layer on top of the generated client and never changes generated code.

require_relative 'agent_workflows/destination'
require_relative 'agent_tools/errors'
require_relative 'agent_tools/wire'
require_relative 'agent_tools/header'
require_relative 'agent_tools/schema'
require_relative 'agent_tools/validate'
require_relative 'agent_tools/tool'
require_relative 'agent_tools/webhook_tool'
require_relative 'agent_tools/client_tool'
require_relative 'agent_tools/system_tool'

module Elevenlabs
  module AgentTools
    # The workflow builder's Destination, shared by both builders (transfer system tools take the same
    # destinations as workflow transfer nodes).
    Destination = ::Elevenlabs::AgentWorkflows::Destination
  end
end
