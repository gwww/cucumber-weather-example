Feature: Get historic weather for city
    As a historian
    In order to find a city's weather for a date in the past
    I need to be able to search Weather Underground with a date

    Scenario Outline: Find weather when for city on given date
        Given I am authorized to use the Weather Underground API
        When I search for <Location> weather for date <Date>
        Then I should see the temperature <Temperature>

        Examples:
            |Location          |Date     |Temperature |
            |"IA/Cedar_Rapids" |20091213 |32          |
            |"Canada/Edmonton" |20091213 |-51         |
