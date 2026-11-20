# frozen_string_literal: true

# Agents as code: an Agent builder composing an agent's settings, its tools and its workflow; +push+ and
# +pull+ on the generated agents client (+client.agents+); and AgentProject, the ElevenLabs CLI's project
# layout.
#
# Requires the generated SDK to be loaded first (require 'elevenlabs'). It is not loaded by
# +require 'elevenlabs'+; require it explicitly:
#
#   require 'elevenlabs'
#   require 'elevenlabs/agent_builder'
#
#   agent = Elevenlabs::AgentBuilder::Agent.new('Support line', prompt: 'You are a support agent for Acme.')
#   result = client.agents.push(agent)
#   client.agents.push(agent, agent_id: result.agent_id)
#
# Hand-written (see .fernignore). Requiring it also loads the workflow and tool builders, and prepends a
# module with +push+ and +pull+ to the generated agents client, so no generated file changes and every
# request is the generated one.

require_relative 'agent_workflows'
require_relative 'agent_tools'
require_relative 'agent_builder/errors'
require_relative 'agent_builder/wire'
require_relative 'agent_builder/format'
require_relative 'agent_builder/agent'
require_relative 'agent_builder/project_files'
require_relative 'agent_builder/project'
require_relative 'agent_builder/push'
