#!/usr/bin/env python3
# coding: utf-8

import psycopg2
import datetime

def getQuery(num):
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_query = "select * from query%s"

        cursor.execute(select_query, (num,))

        result = cursor.fetchall()
        print("\n")
        if num == 1 or num == 2 or num ==4 or num == 9:
            for row in result:
                print("%s %s"% (row[0], row[1]))
        else:
            for row in result:
                print("%s"% (row[0]))

        print("===================================== \n")

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()
            # print("PostgreSQL connection is closed \n")

def setCampaign():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        insert_campaign = """ insert into Campaigns (campaign_name, area, start_date, end_date, topic, budgets)
        values(%s, %s, %s, %s, %s, %s)"""

        campaign_name = raw_input("Campaign name: ")
        area = raw_input("Area: ")
        start_date = raw_input("Start date: ")
        end_date = raw_input("End date: ")
        topic = raw_input("Topic: ")
        budgets = raw_input("Budgets: ")

        data_campaign = (campaign_name, area, start_date, end_date, topic, int(budgets))

        cursor.execute(insert_campaign, data_campaign)

        dbconn.commit()
        print("Record inserted successfully into Campaign table")

    except(Exception, psycopg2.Error) as error:
        if(dbconn):
            print("Failed to insert record into table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def addNewEvent():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        insert_events = """ insert into Events(event_name, start_time, end_time, place, tools)
        values(%s, %s, %s, %s, %s)"""

        insert_run = """ insert into run(campaign_name, event_name) values(%s, %s)"""

        campaign_name = raw_input("Campaign name: ")
        event_name  = raw_input("Event name: ")
        start_time = raw_input("Start time(0000-00-00 00:00:00): ")
        end_time = raw_input("End time(0000-00-00 00:00:00): ")
        place = raw_input("Place(public squares/ street corner): ")
        tools = raw_input("Tools: ")
        data_events = (event_name, start_time, end_time, place, tools)
        data_run = (campaign_name, event_name)


        cursor.execute(insert_events, data_events)
        cursor.execute(insert_run, data_run)

        dbconn.commit()
        print("New event have been inserted")

    except(Exception, psycopg2.Error) as error:
        if(dbconn):
            print("Failed to insert record into table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def addNewVol():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        insert_vol = """ insert into Volunteers (volunteer_id, first_name, last_name, tiers)
        values(%s, %s, %s, %s)"""

        volunteer_id  = raw_input("Volunteer ID: ")
        first_name = raw_input("First name: ")
        last_name = raw_input("Last name: ")
        tiers = 1
        data_vol = (int(volunteer_id), first_name, last_name, tiers)

        cursor.execute(insert_vol, data_vol)

        dbconn.commit()
        print("New Volunteer have been inserted")

    except(Exception, psycopg2.Error) as error:
        if(dbconn):
            print("Failed to insert record into table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def updateVol():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        update_part = """ update participate set volunteer_id = %s where event_name = %s"""

        volunteer_id  = raw_input("Volunteer ID: ")
        event_name = raw_input("Event name: ")
        data_part = (int(volunteer_id), event_name)

        cursor.execute(update_part, data_part)

        dbconn.commit()
        print("Volunteer have been updated to current event")

    except(Exception, psycopg2.Error) as error:
        if(dbconn):
            print("Failed to update record into table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def updateSchedule():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        update_events = """ update events set start_time = %s where event_name = %s"""
        update_end_events = """ update events set end_time = %s where event_name = %s"""

        event_name = raw_input("Event name: ")
        start_time  = raw_input("New start schedule(0000-00-00 00:00:00): ")
        end_time  = raw_input("New end schedule(0000-00-00 00:00:00): ")


        data_events = (start_time, event_name)
        end_data_events = (end_time, event_name)

        cursor.execute(update_events, data_events)
        cursor.execute(update_end_events, end_data_events)

        dbconn.commit()
        print("New schedule have been updated to current event")

    except(Exception, psycopg2.Error) as error:
        if(dbconn):
            print("Failed to update record into table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def checkCampaign():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_campaign = "select * from Campaigns"

        cursor.execute(select_campaign)

        result = cursor.fetchall()

        for row in result:
            print("%s, %s, %s, %s, %s, %s"% (row[0], row[1], row[2], row[3], row[4], row[5]))

        print("================= \n")

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def checkEvents():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_campaign = "select * from Events"

        cursor.execute(select_campaign)

        result = cursor.fetchall()

        for row in result:
            print("%s, %s, %s, %s, %s"% (row[0], row[1], row[2], row[3], row[4]))

        print("================= \n")

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def checkVolunteers():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_campaign = "select * from Volunteers"

        cursor.execute(select_campaign)

        result = cursor.fetchall()

        for row in result:
            print("%s, %s, %s, %s"% (row[0], row[1], row[2], row[3]))

        print("=========================================== \n")

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def costBar():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        cursor.execute(""" select campaign_name, budgets from Campaigns """)

        result = cursor.fetchall()
        data = []
        # row[0] : campaign_name
        # row[1] : budgets
        for row in result:
            data.append((row[0],row[1]))

        max_value = max(count for _, count in data)
        increment = max_value / 25

        longest_label_length = max(len(label) for label, _ in data)

        for label, count in data:

            bar_chunks, remainder = divmod(int(count * 8 / increment), 8)

            bar = '█' * bar_chunks

            # if remainder > 0:
                # bar += chr(ord('-') + (8 - remainder))

            bar = bar or  '▏'
            print("{}| {} {} dollars".format(label.rjust(longest_label_length), bar, count))

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def addAnnotation():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        cursor.execute("""
            alter table campaigns
            add column annotation text
        """)

        dbconn.commit()


    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def updateAnnotation():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        update_annotation = " update campaigns set annotation = %s where campaign_name = %s"
        campaign_name = raw_input("Enter campaign name:")
        data_annotation = raw_input("Enter the annotation: ")

        cursor.execute(update_annotation, (data_annotation, campaign_name))

        dbconn.commit()


    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def checkCamAnn():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_campaign = "select campaign_name, annotation from Campaigns"

        cursor.execute(select_campaign)

        result = cursor.fetchall()

        for row in result:
            print("%s, %s"% (row[0], row[1]))

        print("================= \n")

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def addRecord():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        cursor.execute("""
            alter table volunteers
            add column record text
        """)

        dbconn.commit()


    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def updateRecords():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        update_record = " update volunteers set record = %s where first_name = %s"
        first_name = raw_input("Enter volunteer first name:")
        data_record = raw_input("Enter the record: ")

        cursor.execute(update_record, (data_record, first_name))

        dbconn.commit()


    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def checkVolRec():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_volunteer = "select first_name, record from volunteers"

        cursor.execute(select_volunteer)

        result = cursor.fetchall()

        for row in result:
            print("%s, %s"% (row[0], row[1]))

        print("================= \n")

    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()


def showVolBar():
    try:
        dbconn = psycopg2.connect(host='studsql.csc.uvic.ca', user='upper', password='oazsbnE!jh')
        cursor = dbconn.cursor()

        select_volunteer = """ select event_name, count(*) from participate group by event_name; """

        cursor.execute(select_volunteer)

        result = cursor.fetchall()
        data = []
        # row[0] : event_name
        # row[1] : volunteer amount
        for row in result:
            data.append((row[0],int(row[1])))


        max_value = max(count for _, count in data)
        increment = max_value / 4
        longest_label_length = max(len(label) for label, _ in data)

        for label, count in data:
            bar_chunks, remainder = divmod(int(count * 8 / increment), 8)

            bar = '█' * bar_chunks

            # if remainder > 0:
                # bar += chr(ord('-') + (8 - remainder))

            bar = bar or  '▏'
            print("{}| {} {} volunteers".format(label.rjust(longest_label_length), bar, count))


    except(Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if(dbconn):
            cursor.close()
            dbconn.close()

def main():
    print("Welcome to GnG database!")
    requestNum = 1000000
    while requestNum != 0:
        print("\n")
        print("What do you want to do today?")
        print("""
            Enter 1 : Search the existing queries. \n
            Enter 2 : Setting up a campaign with volunteers, events. \n
            Enter 3 : Accounting information \n
            Enter 4 : Membership history and Campaign annotations\n
            Enter 5 : Volunteer event records \n
            """)
        requestNum = input("Please enter the number(Type 0 to quit): ")
        # Searching from existing queries
        if requestNum == 1:
            queryNum = 1000000

            while queryNum != 0:
                print("\n")
                print("Please choose from one of the queries below.")
                print("""
                    Query1 : Which member have donated more than 30000 dollars? \n
                    Query2 : Find the member have donated the most money. \n
                    Query3 : Which campaign have push on the website since they start the campaign? \n
                    Query4 : Who join the campaign “Save the dolphins?” \n
                    Query5 : How many volunteers join the campaign “Bus life?” \n
                    Query6 : Which campaign have only one volunteer? \n
                    Query7 : Which campaigns have Jake Peralta (id=88) volunteer in? \n
                    Query8 : How many campaiagns have Terry Jeffords go to? \n
                    Query9 : Which employee have been paid the most? \n
                    Query10 : How many volunteers join the campaign “Save the trees?” \n
                    """)

                queryNum = input("Please enter the query number(Enter 0 to quit):")

                if queryNum < 0 or queryNum > 10:
                    print("The query is not existed. Please try again.")
                    queryNum = input("Please enter the query number(Enter 0 to quit):")
                else:
                    print("The result from Query%s: "% (queryNum))
                    getQuery(queryNum)

        elif requestNum == 2:
            setNum = 1000000
            while setNum != 0:
                print("\n")
                print("Please choose what you want to do with the database.")
                print("""
                    Enter 1 : Adding new Campaign \n
                    Enter 2 : Adding new Events \n
                    Enter 3 : Adding new Volunteer \n
                    Enter 4 : Updating Volunteer to current events \n
                    Enter 5 : Updating new scheduling \n
                    Enter 6 : Check current Campaign status \n
                    Enter 7 : Check current Events status \n
                    Enter 8 : Check current Volunteers status \n
                    """)
                setNum = input("Please enter the number here(Enter 0 to go back):")
                if setNum == 1:
                    setCampaign()
                elif setNum == 2:
                    addNewEvent()
                elif setNum == 3:
                    addNewVol()
                elif setNum == 4:
                    updateVol()
                elif setNum == 5:
                    updateSchedule()
                elif setNum == 6:
                    checkCampaign()
                elif setNum == 7:
                    checkEvents()
                elif setNum == 8:
                    checkVolunteers()
                else:
                    print("No function have been chosen")

        elif requestNum == 3:
            print("\n")
            print("This is the budgets for current campaigns.\n")
            costBar()
            print("===========================================\n")

        elif requestNum == 4:
            # Membership history and Campaign annotations
            addAnnotation()
            addRecord()
            key = 1000000
            while key != 0:
                print("\n")
                print("""
                    Enter 1 : Adding annotation \n
                    Enter 2 : Check current Campaign annotation \n
                    Enter 3 : Adding volunteer records \n
                    Enter 4 : Check current volunteer records \n
                    """)
                key = input("Please enter the number here(Enter 0 to go back):")
                if key == 1:
                    updateAnnotation()
                elif key == 2:
                    checkCamAnn()
                elif key == 3:
                    updateRecords()
                elif key == 4:
                    checkVolRec()
                else:
                    print("No function have been chosen")

        elif requestNum == 5:
            ownKey = 1000000
            while ownKey != 0:
                print("\n")
                print("""
                    Enter 1 : Show all the data for every Volunteers \n
                    Enter 2 : Shaw the human resourses for each campaign \n
                    """)

                ownKey = input("Please enter the number here(Enter 0 to go back):")
                if ownKey == 1:
                    checkVolunteers()
                elif ownKey == 2:
                    showVolBar()
                else:
                    print("No function have been chosen")

        else:
            print("Nothing have been chosen.")

if __name__ == "__main__": main()
