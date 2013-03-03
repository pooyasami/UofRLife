<?php

/**
 * This is the PHP service for the iphone application which recieves the user
 * requests using post and responds accordingly.
 */
$action = $_POST[action];
$username = $_POST[username];
$normalPass = $_POST[password];
$location = $_POST[location];
$name = $_POST[name];
$room = $_POST[room];
$event_type = $_POST[event_type];
$vendingMachine_id = $_POST[vmachine_id];

$event_id = $_POST[event_id];
$establishment_id = $_POST[establishment_id];
$eventName = $_POST[event_name];
$eventDescription = $_POST[event_description];
$eventStartTime = $_POST[event_start_time];
$eventEndTime = $_POST[event_end_time];
$eventAgeRange = $_POST[event_age_range];
$feedback = $_POST[feedback];

if ($action == "login") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);

    if ($dbc->checkPassword($username, $hashedPassword)) {
        echo "<p>You successfully logged in.</p>";
    } else {
        echo "<p>wrong username or password.</p>";
    }
    $dbc->close();
} if ($action == "getevents") {
    //SELECT * FROM events join entities on events.entity_id = entities.id join locations on entities.location_id = locations.id
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEventsAccordingToLocation($location, TRUE);
    $dbc->close();
} if ($action == "getestablishments") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEstablishmentsByLocation($location, TRUE);
    $dbc->close();
} if ($action == "myevents") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    //echo "$hashedPassword";
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->getMyEvents($username);
    } else {
        echo "<p>wrong username or password.</p>";
    }
    $dbc->close();
} if ($action == "editevent") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        if ($dbc->confirmEventBelongsToUser($event_id, $username)) {
            $dbc->editEvent($username, $event_id, $eventName, $eventDescription, $eventStartTime, $eventEndTime, $eventAgeRange, $location, $room, $event_type);
        }
    } else {
        echo "<p>wrong username or password.</p>";
    }
    $dbc->close();
} if ($action == "addevent") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->addEvent($username, $eventName, $eventDescription, $eventStartTime, $eventEndTime, $eventAgeRange, $location, $room, $event_type);
    }
    $dbc->close();
} if ($action == "deleteevent") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        if ($dbc->confirmEventBelongsToUser($event_id, $username)) {
            $dbc->deleteEvent($username, $event_id);
        }
    }
    $dbc->close();
} if ($action == "getevent") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEventAccordingToID($event_id);
    $dbc->close();
} if ($action == "eventfeedback") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEventFeedback($event_id);
    $dbc->close();
} if ($action == "addeventfeedback") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->addEventFeedback($event_id, $username, $feedback);
    }
    $dbc->close();
} if ($action == "getestablishment") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEstablishmentAccordingToID($establishment_id);
    $dbc->close();
} if ($action == "establishmentfeedback") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEstablishmentFeedback($establishment_id);
    $dbc->close();
} if ($action == "getestablishmentitems") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getEstablishmentItems($establishment_id);
    $dbc->close();
} if ($action == "getsubscribed") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->getSubscriptions($username);
    }
    $dbc->close();
} if ($action == "subscribe-unsubscribetoevent") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->subscribeToEvent($username, $event_id);
    }
    $dbc->close();
} if ($action == "issubscribed") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $dbc->isUserSubscribedToEvent($username, $event_id);
    $dbc->close();
} if ($action == "getsubscribers") {
    $dbc = new DataBaseConnectivity ();
    $dbc->connectToDB();
    $dbc->getSubscribers($event_id);
    $dbc->close();
} if ($action == "addestablishmentfeedback") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->addEstablishmentFeedback($establishment_id, $username, $feedback);
    }
    $dbc->close();
} if ($action == "getvmachines") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getVMachinesAccordingToLocation($location, TRUE);
    $dbc->close();
} if ($action == "addvmachinefeedback") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $hashedPassword = $dbc->hashPassword($normalPass);
    if ($dbc->checkPassword($username, $hashedPassword)) {
        $dbc->addVMachineFeedback($vendingMachine_id, $username, $feedback);
    }
    $dbc->close();
} if ($action == "vmachinefeedback") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->getVMachineFeedback($vendingMachine_id);
    $dbc->close();
} if ($action == "getStats") {
    $dbc = new DataBaseConnectivity();
    $dbc->connectToDB();
    $dbc->buildingsStats();
    $dbc->close();
}

/**
 * The class for database interaction. It can connect to the Database and
 * does the proper functions accoring to the action it recieves. It returns
 * the data in XML format so it can be parsed in the iPhone.
 */
class DataBaseConnectivity {

    /**
     * Connection to the database
     * @var <Connection>
     */
    var $connection;

    /**
     * It creates a conneciton to the Database, This is where the username,
     * password and database name gets entered.
     */
    function connectToDB() {
        $con = mysql_connect("localhost", "myurli5_urlife", "urlife2011");
        if (!$con) {
            echo "could not connect to db";
            die('Could not connect: ' . mysql_error());
        }
        mysql_select_db("myurli5_urlife");
        $connection = $con;

        $this->connection = $con;
    }

    /**
     * This function hashes the password.
     * @param <String> $pass
     * @return <String> the hashed password
     */
    function hashPassword($pass) {
        $salt = '045ea9e62053449cdfb3b3cb5f337d7eddf92bcb';
        $hashedPassword = sha1($salt . $pass);
        return $hashedPassword;
    }

    /**
     * This method returns true if the username and password entered are right
     * @param <String> $username the username
     * @param <String> $pass the password
     * @return <boolean> true if the username and password match.
     */
    function checkPassword($username, $pass) {
        $query = "select * from users where username='$username' and password='$pass'";
        $result = mysql_query($query);
        $test = mysql_num_rows($result);
        if ($test == 1) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    /**
     * It returns the events accordin to the event_id
     * @param <String> $event_id the id of the event
     */
    function getEventAccordingToID($event_id) {
        $query = "SELECT *, events.type as event_type , events.id as id, locations.name as locationname, events.name as eventname FROM events join entities on events.entity_id = entities.id join locations on entities.location_id = locations.id where events.id = '$event_id'";
        $result = mysql_query($query);

        $numberOfRows = mysql_num_rows($result);
        //echo "<p>Number of rows in the result = $numberOfRows</p>";
        if ($numberOfRows > 0) {
            $row = mysql_fetch_array($result, MYSQL_ASSOC);
            echo "<root>";
            echo "<event><id>{$row['id']}</id><name>{$row['eventname']}</name>" .
            "<timestart>{$row['time_start']}</timestart>" .
            "<timeend>{$row['time_end']}</timeend>" .
            "<description>{$row['description']}</description>" .
            "<agerange>{$row['ageRange']}</agerange>" .
            "<type>{$row['type']}</type>" .
            "<location>{$row['locationname']}</location>" .
            "<room>{$row['room']}</room>" .
            "<event_type>{$row['event_type']}</event_type>" .
            "</event>";
            echo "</root>";
        } else {
            echo "event does not exist";
        }
    }

    /**
     * It returns the information of the establishment according to the ID
     * @param <String> $establishment_id. Establishment ID
     */
    function getEstablishmentAccordingToID($establishment_id) {
        $query = "SELECT *, establishments.id as id, locations.name as locationname FROM establishments join entities on establishments.entity_id = entities.id join locations on entities.location_id = locations.id where establishments.id = '$establishment_id'";
        $result = mysql_query($query);

        $numberOfRows = mysql_num_rows($result);
        //echo "<p>Number of rows in the result = $numberOfRows</p>";
        if ($numberOfRows > 0) {
            echo "<root>";
            while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
                echo "<establishment><id>{$row['id']}</id><vendor>{$row['vendor']}</vendor>" .
                "<timeopen>{$row['timeOpen']}</timeopen>" .
                "<timeclose>{$row['timeClose']}</timeclose>" .
                "<description>{$row['description']}</description>" .
                "<location>{$row['locationname']}</location>" .
                "</establishment>";
            }
            echo "</root>";
        } else {
            echo "establishment does not exist";
        }
    }

    /**
     * It is for getting the information of the events according to the location
     * @param <String> $location name of the location
     * @param <boolean> $dataNeeded true if there is need for data or false if there is no need for data.
     * it is basically for checking if there are events in a particular building.
     * @return <boolean> true if there are events in the location (the $dataNeeded should be true if there
     * is a need for boolean return type).
     */
    function getEventsAccordingToLocation($location, $dataNeeded) {
        //SELECT * FROM events join entities on events.entity_id = entities.id join locations on entities.location_id = locations.id where location.name = '$location'
        $query = "SELECT *,events.type as event_type , events.id as id, locations.name as locationname, events.name as eventname FROM events join entities on events.entity_id = entities.id join locations on entities.location_id = locations.id where locations.name = '$location' and time_end BETWEEN DATE_ADD(CURDATE(), INTERVAL -2 DAY) AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH) ORDER BY time_start ASC";
        //SELECT *,events.type as event_type , events.id as id, locations.name as locationname, events.name as eventname FROM events join entities on events.entity_id = entities.id join locations on entities.location_id = locations.id where locations.name = 'Dr. William Riddell Centre' and time_end BETWEEN DATE_ADD(CURDATE(), INTERVAL -2 DAY) AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
        $result = mysql_query($query);

        $numberOfRows = mysql_num_rows($result);
        //echo "<p>Number of rows in the result = $numberOfRows</p>";
        if ($numberOfRows > 0) {
            if ($dataNeeded) {
                echo "<root>";
                while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
                    echo "<event><id>{$row['id']}</id><name>{$row['eventname']}</name>" .
                    "<timestart>{$row['time_start']}</timestart>" .
                    "<timeend>{$row['time_end']}</timeend>" .
                    "<description>{$row['description']}</description>" .
                    "<agerange>{$row['ageRange']}</agerange>" .
                    "<type>{$row['type']}</type>" .
                    "<location>{$row['locationname']}</location>" .
                    "<room>{$row['room']}</room>" .
                    "<event_type>{$row['event_type']}</event_type>" .
                    "</event>";
                }
                echo "</root>";
            } else {
                return TRUE;
            }
        } else {
            //echo "No results for location $location.";
            return FALSE;
        }
    }

    /**
     * It returns the events that the user owns
     * @param <Sring> $username the username
     */
    function getMyEvents($username) {
        $query = "select *, events.type as event_type, events.id as id, locations.name as locationname, events.name as eventname, events.time_start as time_start, events.time_end as time_end, events.description as description, events.ageRange as ageRange from events join entities on events.entity_id = entities.id join locations on entities.location_id = locations.id join users on users.id = entities.user_id where users.username = '$username'";
        $result = mysql_query($query);
        $numberOfRows = mysql_num_rows($result);
        if ($numberOfRows > 0) {
            echo "<root>";
            while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
                echo "<event><id>{$row['id']}</id><name>{$row['eventname']}</name>" .
                "<timestart>{$row['time_start']}</timestart>" .
                "<timeend>{$row['time_end']}</timeend>" .
                "<description>{$row['description']}</description>" .
                "<agerange>{$row['ageRange']}</agerange>" .
                "<location>{$row['locationname']}</location>" .
                "<room>{$row['room']}</room>" .
                "<event_type>{$row['event_type']}</event_type>" .
                "</event>";
            }
            echo "</root>";
        }
    }

    /**
     * It is for editing the event
     * @param <String> $username the user that owns it
     * @param <String> $eventid event id
     * @param <String> $eventname name of the event
     * @param <String> $eventdescription event description
     * @param <String> $eventtimestart event start time
     * @param <String> $eventtimeend event end time
     * @param <String> $eventagesrange event age range
     * @param <String> $eventlocation event location
     * @param <String> $room evenr room number
     * @param <String> $event_type  event type
     */
    function editEvent($username, $eventid, $eventname, $eventdescription, $eventtimestart, $eventtimeend, $eventagesrange, $eventlocation, $room, $event_type) {


        $locID = $this->getLocationID($eventlocation);

        echo "<p>$locID</p>";
        if ($locID != -1) {
            $query = "update events set ageRange = '$eventagesrange',  description = '$eventdescription', time_end= '$eventtimeend', time_start = '$eventtimestart',  name = '$eventname', room ='$room' , type = '$event_type' where id = '$eventid'";
            mysql_query($query);

            $query3 = "select entities.id from events join entities on entities.id = events.entity_id where events.id = '$eventid'";
            $result = mysql_query($query3);
            $row = mysql_fetch_array($result);
            $entity_id = "{$row['id']}";

            $query4 = "update entities set entities.location_id = '$locID' where entities.id = '$entity_id'";
            mysql_query($query4);

            echo "edit event done";
        }
    }

    /**
     * It returns true if the user owns the event
     * @param <String> $eventid event id
     * @param <String> $username the username
     * @return <boolean> true if the user owns the event
     */
    function confirmEventBelongsToUser($eventid, $username) {
        $query = "select * from events join entities on entities.id = events.entity_id join users on entities.user_id = users.id where users.username = '$username' and events.id = '$eventid'";
        $result = mysql_query($query);
        $numberOfRows = mysql_num_rows($result);
        if ($numberOfRows > 0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    /**
     * It is for adding an event.
     * @param <String> $username the username
     * @param <String> $eventname event name
     * @param <String> $eventdescription event description
     * @param <String> $eventtimestart event start time
     * @param <String> $eventtimeend event end time
     * @param <String> $eventagesrange event age range
     * @param <String> $eventlocation event location
     * @param <String> $room event room number
     * @param <String> $event_type event type
     */
    function addEvent($username, $eventname, $eventdescription, $eventtimestart, $eventtimeend, $eventagesrange, $eventlocation, $room, $event_type) {
        $locID = $this->getLocationID($eventlocation);
        $userID = $this->getUserID($username);
        //echo "user id = $userID    loc id = $locID";
        if ($locID != -1) {
            $query = "insert into entities (user_id, location_id, type) values ('$userID', '$locID', 'event')";
            mysql_query($query);
            $entity_id = mysql_insert_id();
            $query1 = "insert into events (entity_id, name, time_start, time_end, description, ageRange, room, type) values ('$entity_id','$eventname', '$eventtimestart', '$eventtimeend', '$eventdescription', '$eventagesrange', '$room', '$event_type')";
            mysql_query($query1);

            echo 'add event done';
        }
    }

    /**
     * The function for deleting the event from the database
     * @param <type> $username the username
     * @param <type> $eventID event id
     */
    function deleteEvent($username, $eventID) {
        $userID = $this->getUserID($username);
        $entityID = $this->getEntityId($eventID);
        $query1 = "delete from events where events.id = '$eventID'";
        $query2 = "delete from entities where entities.id = '$entityID'";
        mysql_query($query1);
        mysql_query($query2);
        echo "event deleted";
    }

    /**
     * It gets the entity ID of an event. This is an internal method.
     * @param <String> $eventID event id
     * @return <Integer> it returns the entity ID or -1 if it doesn't exist.
     */
    function getEntityId($eventID) {
        $query = "select entity_id from events where id = '$eventID'";
        $result = mysql_query($query);
        $numberOfFields = mysql_num_rows($result);
        if ($numberOfFields > 0) {
            $row = mysql_fetch_array($result);
            $id = "{$row['entity_id']}";
            return $id;
        } else {
            return -1;
        }
    }

    /**
     * It returns the location ID of the location accordin to the name. This is
     * an internal method.
     * @param <String> $locationName name of the location
     * @return <Integer> it returns the location ID or -1 if it doesn't exist.
     */
    function getLocationID($locationName) {
        $query = "select locations.id from locations where locations.name = '$locationName' ";
        $result = mysql_query($query);
        $numberOfFields = mysql_num_rows($result);
        if ($numberOfFields > 0) {
            $row = mysql_fetch_array($result);
            $id = "{$row['id']}";
            return $id;
        } else {
            return -1;
        }
    }

    /**
     * It returns the user ID of the given username
     * @param <String> $username the username
     * @return <Integer> the ID of the user or -1 if it doesn't exist
     */
    function getUserID($username) {
        $query = "select users.id from users where users.username = '$username'";
        $result = mysql_query($query);
        $numberOfFields = mysql_num_rows($result);
        if ($numberOfFields > 0) {
            $row = mysql_fetch_array($result);
            $userID = "{$row['id']}";
            return $userID;
        } else {
            return -1;
        }
    }

    /**
     * The getter method for the connection
     * @return <Connection> the connection
     */
    function getConnection() {
        return $this->connection;
    }

    /**
     * It closes the conneciton
     */
    function close() {
        mysql_close($this->connection);
    }

    /**
     * It returns all the establishments of the given location
     * @param <String> $location the location name
     * @param <boolean> $dataNeeded true if there is need for data or false if there is no need for data.
     * it is basically for checking if there are establishments in a particular building.
     * @return <boolean> true if there are establishments in the location (the $dataNeeded should be true if there
     * is a need for boolean return type).
     */
    function getEstablishmentsByLocation($location, $dataNeeded) {
        $query = "SELECT *, establishments.id as id, locations.name as locationname, establishments.vendor as establishmentname FROM establishments join entities on establishments.entity_id = entities.id join locations on entities.location_id = locations.id where locations.name = '$location'";
        $result = mysql_query($query);

        $numberOfRows = mysql_num_rows($result);
        //echo "<p>Number of rows in the result = $numberOfRows</p>";
        if ($numberOfRows > 0) {
            if ($dataNeeded) {
                echo "<root>";
                while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
                    echo "<establishment><id>{$row['id']}</id><vendor>{$row['establishmentname']}</vendor>" .
                    "<timeopen>{$row['timeOpen']}</timeopen>" .
                    "<timeclose>{$row['timeClose']}</timeclose>" .
                    "<description>{$row['description']}</description>" .
                    "<location>{$row['locationname']}</location>" .
                    "</establishment>";
                }
                echo "</root>";
            } else {
                return TRUE;
            }
        } else {
            //echo "No results for location $location.";
            return FALSE;
        }
    }

    /**
     * The method for adding feedback to the event
     * @param <String> $eventid event id
     * @param <String> $username the username
     * @param <String> $feedback the comment/feedback
     */
    function addEventFeedback($eventid, $username, $feedback) {

        $query = "INSERT INTO eventfeedbacks (event_id, name, feedback) VALUES('$eventid', '$username', '$feedback')";

        echo "$query";

        mysql_query($query);
    }

    /**
     * The method for adding feedback to the establishment
     * @param <String> $establishment_id establishment id
     * @param <String> $username the username
     * @param <String> $feedback the comment/feedback
     */
    function addEstablishmentFeedback($establishment_id, $username, $feedback) {
        $query = "INSERT INTO establishmentfeedbacks (establishment_id, name, feedback) VALUES('$establishment_id', '$username', '$feedback')";
        mysql_query($query);
    }

    /**
     * The method for adding feedback to the vending machine
     * @param <String> $vendingMachine_id vmachine id
     * @param <String> $username the username
     * @param <String> $feedback the comment/feedback
     */
    function addVMachineFeedback($vendingMachine_id, $username, $feedback) {
        $query = "INSERT INTO vmachinefeedbacks (vmachine_id, name, feedback) VALUES('$vendingMachine_id', '$username', '$feedback')";
        mysql_query($query);
    }

    /**
     * Returns the feedbacks of an event
     * @param <String> $event_id event id
     */
    function getEventFeedback($event_id) {
        $query = "SELECT * FROM eventfeedbacks WHERE event_id='$event_id'";
        $result = mysql_query($query);

        echo "<root>";
        while ($row = mysql_fetch_array($result)) {
            echo "<feedback><name>{$row['name']}</name><comment>" . $row['feedback'] . "</comment></feedback>";
        }
        echo "</root>";
    }

    /**
     * Returns the feedbacks of an establishment
     * @param <String> $establishment_id establishment id
     */
    function getEstablishmentFeedback($establishment_id) {
        $query = "SELECT * FROM establishmentfeedbacks WHERE establishment_id='$establishment_id'";
        $result = mysql_query($query);

        echo "<root>";
        while ($row = mysql_fetch_array($result)) {
            echo "<feedback><name>{$row['name']}</name><comment>" . $row['feedback'] . "</comment></feedback>";
        }
        echo "</root>";
    }

    /**
     * Returns the feedbacks of a vending machine
     * @param <String> $vendingMachine_id vendingMachine_id
     */
    function getVMachineFeedback($vendingMachine_id) {
        $query = "SELECT * FROM vmachinefeedbacks WHERE vmachine_id='$vendingMachine_id'";
        $result = mysql_query($query);

        echo "<root>";
        while ($row = mysql_fetch_array($result)) {
            echo "<feedback>" .
            "<name>{$row['name']}</name>" .
            "<comment>{$row['feedback']}</comment>" .
            "</feedback>";
        }
        echo "</root>";
    }

    /**
     * It returns the items of an establishment according to the establishment ID
     * @param <String> $establishment_id establishment ID
     */
    function getEstablishmentItems($establishment_id) {
        $query = "select * from establishmentitems where establishment_id = '$establishment_id'";
        $result = mysql_query($query);

        echo "<root>";
        while ($row = mysql_fetch_array($result)) {
            echo "<item>";

            echo "<type>{$row['type']}</type><description>{$row['description']}</description><price>{$row['price']}</price>";

            echo "</item>";
        }
        echo "</root>";
    }

    /**
     * It returns the information of the events that the user has already subscribed to
     * @param <String> $username the username
     */
    function getSubscriptions($username) {

        $query = "SELECT events.type as event_type, events.id as id, locations.name as locationname, events.name as eventname, events.time_start as time_start, events.time_end as time_end, events.description as description, events.ageRange as ageRange FROM events LEFT JOIN subscriptions ON events.id = subscriptions.event_id LEFT JOIN entities ON entities.id = events.id LEFT JOIN users ON users.id = subscriptions.user_id LEFT JOIN locations ON locations.id = entities.location_id where username = '$username'";
        $result = mysql_query($query);

        echo "<root>";

        while ($row = mysql_fetch_array($result)) {
            echo "<event><id>{$row['id']}</id><name>{$row['eventname']}</name>" .
            "<timestart>{$row['time_start']}</timestart>" .
            "<timeend>{$row['time_end']}</timeend>" .
            "<description>{$row['description']}</description>" .
            "<agerange>{$row['ageRange']}</agerange>" .
            "<location>{$row['locationname']}</location>" .
            "<event_type>{$row['event_type']}</event_type>" .
            "</event>";
        }

        echo "</root>";
    }

    /**
     * It subscribes or unsubscribes to the event according to the current status
     * of the subscription. (it switches between the states).
     * @param <String> $username the username
     * @param <String> $event_id event id
     */
    function subscribeToEvent($username, $event_id) {
        $query1 = "select * from subscriptions where user_id = (select id from users where username='$username') and event_id = $event_id";

        $result = mysql_query($query1);
        $numberOfRows = mysql_num_rows($result);

        if ($numberOfRows == 0) {
            $query = "insert into subscriptions (user_id,event_id) values ((select id from users where username='$username'), $event_id)";
            mysql_query($query);
        } else {
            $query = "delete from subscriptions where user_id = (select id from users where username='$username') and event_id = $event_id";
            mysql_query($query);
        }
    }

    /**
     * It checks if the user is subscribed to an event
     * @param <String> $username the username
     * @param <String> $event_id  event id
     */
    function isUserSubscribedToEvent($username, $event_id) {
        $query = "select * from subscriptions where user_id = (select id from users where username='$username') and event_id = $event_id";

        $result = mysql_query($query);
        $numberOfRows = mysql_num_rows($result);

        if ($numberOfRows != 0) {
            echo "subscribed";
        } else {
            echo "not subscribed";
        }
    }

    /**
     * it gets the subscribers to an event
     * @param <String> $event_id event id
     */
    function getSubscribers($event_id) {
        $query = "SELECT username FROM users JOIN subscriptions ON users.id = subscriptions.user_id WHERE subscriptions.event_id = '$event_id'";

        $result = mysql_query($query);

        echo "<root>";
        while ($row = mysql_fetch_array($result)) {
            echo "<subscriber><username>{$row['username']}</username></subscriber>";
        }
        echo "</root>";
    }

    /**
     * It returns information of the vending machiens according to the location
     * @param <String> $location the location
     * @param <boolean> $dataNeeded true if there is need for data or false if there is no need for data.
     * it is basically for checking if there are vending machines in a particular building.
     * @return <boolean> true if there are vending machines in the location (the $dataNeeded should be true if there
     * is a need for boolean return type).
     */
    function getVMachinesAccordingToLocation($location, $dataNeeded) {
        $query = "select cardEnable, locations.name as location, vmachines.id as v_id , vmachines.floor, vmachines.items from vmachines join entities on entities.id = vmachines.entity_id join locations on locations.id = entities.location_id where locations.name = '$location'";
        $result = mysql_query($query);

        $numberOfRows = mysql_num_rows($result);

        if ($numberOfRows > 0) {
            if ($dataNeeded) {
                echo "<root>";
                while ($row = mysql_fetch_array($result)) {
                    echo "<vmachine><location>{$row['location']}</location>" .
                    "<id>{$row['v_id']}</id>" .
                    "<floor>{$row['floor']}</floor>" .
                    "<items>{$row['items']}</items>" .
                    "<card>{$row['cardEnable']}</card></vmachine>";
                }
                echo "<root>";
            } else {
                return TRUE;
            }
        } else {
            return FALSE;
        }
    }

    /**
     * It returns the information of all buildings for showing if there
     * are vending machines, events and establishments. 
     */
    function buildingsStats() {
        $locationsQuery = "select name from locations";
        $locationsArray = mysql_query($locationsQuery);

        echo "<root>";
        while ($row = mysql_fetch_array($locationsArray)) {
            $location = $row[name];
            echo "<building>";
            echo "<name>$location</name>";
            if ($this->getEstablishmentsByLocation($location, FALSE)) {
                echo "<establishment>yes</establishment>";
            } else {
                echo "<establishment>no</establishment>";
            }

            if ($this->getEventsAccordingToLocation($location, FALSE)) {
                echo "<event>yes</event>";
            } else {
                echo "<event>no</event>";
            }

            if ($this->getVMachinesAccordingToLocation($location, FALSE)) {
                echo "<vmachine>yes</vmachine>";
            } else {
                echo "<vmachine>no</vmachine>";
            }
            echo "</building>";
        }
        echo "</root>";
    }

}

?>