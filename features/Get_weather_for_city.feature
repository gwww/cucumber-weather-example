Feature: Get weather for city
    In order to find weather for a city
    I need to be able to search Weather Underground

    Background:
        Given I am authorized to use the Weather Underground API

    Scenario: Find weather when there are multiple matches for the city
        When I search for "Ottawa" weather
        Then I should see a list of 5 locations

    Scenario: Find weather when there is an exact match for the city
        When I search for "Canada/Ottawa" weather
        Then I should see the current weather observation

    Scenario: Find weather when there the city does not exist
        When I search for "MagicKingdom" weather
        Then I should get the error "querynotfound"
