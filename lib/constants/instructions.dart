const getJsonCard = '''
        Write to the user Three activities in total: 
        one Culture and Heritage 
        one Gastronomy 
        one Shopping and Souvenirs 
        And with this structure in JSON format: 
        - name of the activity (nameActivity) 
        - best season to visit (season) 
        - schedule (schedule) 
        - type of activity (typeActivity) 
        - name of the destination to visit (nameDestination) 
        - address (address) 
        - url of the photo (photo) Use the following photos for each type of activity: 
        - Culture and Heritage: https://images.unsplash.com/photo-1526392060635-9d6019884377?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D - Gastronomy: https://images.unsplash.com/photo-1597188446702-9b16067ad718?q=80&w=2776&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8fHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D - Shopping and souvenirs: https://images.unsplash.com/photo-1545206085-d0e519bdcecd?q=80&w=2671&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8fHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D 
''';

const getInitialQuestionNoDestinationChat =
    'Ask the user which destination in Peru they want to travel to or visit, in an excited tone. And add emojis';

const getInitialQuestionNoDestinationChatSecond = '''
        Write to the user Three activities in total: 
        one Culture and Heritage 
        one Gastronomy 
        one Shopping and Souvenirs 
        And with this structure: 
        - name of the activity (nameActivity) 
        - best season to visit (season) 
        - schedule (schedule) 
        - type of activity (typeActivity) 
        - name of the destination to visit (nameDestination) 
        - address (address) 
''';

const getInitialQuestionDestinationChat = '''
        Create an itinerary with this structure: 
        -day number, 
        -safety recommendations for your activities, 
        -and the approximate budget in soles 
        -and dollars.
''';
