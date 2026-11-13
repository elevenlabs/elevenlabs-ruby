# frozen_string_literal: true

module Elevenlabs
  module Types
    module DirectPublishingReadResponseModelGenreItem
      extend ::Elevenlabs::Internal::Types::Enum

      FANTASY = :Fantasy
      ROMANCE = :Romance
      SCIENCE_FICTION = :'Science Fiction'
      MYSTERY_AND_THRILLER = :'Mystery and Thriller'
      ACTION_AND_ADVENTURE = :'Action and Adventure'
      DYSTOPIA = :Dystopia
      BUSINESS_AND_ECONOMICS = :'Business and Economics'
      TECHNOLOGY = :Technology
      CHRISTIAN_INSPIRATIONAL = :'Christian & Inspirational'
      HORROR = :Horror
      BIOGRAPHY_AND_MEMOIR = :'Biography and Memoir'
      EDUCATION_AND_LEARNING = :'Education and Learning'
      HISTORY = :History
      CHILDREN_S_LITERATURE = :"Children's Literature"
      YOUNG_ADULT = :'Young Adult'
      FAIRY_TALES_AND_FOLKLORE = :'Fairy Tales and Folklore'
      FAN_FICTION = :'Fan Fiction'
      GENERAL_FICTION = :'General Fiction'
      HEALTH_AND_WELLNESS = :'Health and Wellness'
      HISTORICAL_FICTION = :'Historical Fiction'
      HUMOR = :Humor
      LITERARY_CLASSICS = :'Literary Classics'
      PHILOSOPHY = :Philosophy
      POETRY = :Poetry
      POLITICS_AND_GOVERNMENT = :'Politics and Government'
      PSYCHOLOGY = :Psychology
      SCIENCE_AND_NATURE = :'Science and Nature'
      SELF_HELP = :'Self-Help'
      SPIRITUALITY_AND_RELIGION = :'Spirituality and Religion'
      TRAVEL = :Travel
      TRUE_CRIME = :'True Crime'
      OTHER = :Other

      def self.load(str)
        coerce(::JSON.parse(str, symbolize_names: true))
      end

      def self.dump(value)
        coerced = coerce(value)
        ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
      end
    end
  end
end
