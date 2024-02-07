sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'faculty/test/integration/FirstJourney',
		'faculty/test/integration/pages/FacultyList',
		'faculty/test/integration/pages/FacultyObjectPage'
    ],
    function(JourneyRunner, opaJourney, FacultyList, FacultyObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('faculty') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheFacultyList: FacultyList,
					onTheFacultyObjectPage: FacultyObjectPage
                }
            },
            opaJourney.run
        );
    }
);