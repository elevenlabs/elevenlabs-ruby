# frozen_string_literal: true

# Agent workflows as code: a chained builder for agent workflows, on top of agents.create / agents.update.
#
# Requires the generated SDK to be loaded first (require 'elevenlabs'). Hand-written (see .fernignore):
# the builder is a layer on top of the generated client and never changes generated code.

require_relative 'agent_workflows/errors'
require_relative 'agent_workflows/wire'
require_relative 'agent_workflows/expr'
require_relative 'agent_workflows/condition'
require_relative 'agent_workflows/destination'
require_relative 'agent_workflows/node_types'
require_relative 'agent_workflows/graph'
require_relative 'agent_workflows/node'
require_relative 'agent_workflows/validate'
require_relative 'agent_workflows/layout'
require_relative 'agent_workflows/workflow'
