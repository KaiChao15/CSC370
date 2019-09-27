--
-- PostgreSQL database dump
--

-- Dumped from database version 10.9 (Ubuntu 10.9-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.9 (Ubuntu 10.9-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: campaigns; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.campaigns (
    campaign_name character(32) NOT NULL,
    area character(20),
    start_date date,
    end_date date,
    topic character(20),
    budgets real
);


ALTER TABLE public.campaigns OWNER TO upper;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character(20),
    last_name character(20),
    salary real
);


ALTER TABLE public.employees OWNER TO upper;

--
-- Name: events; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.events (
    event_name character(32) NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    place character(20),
    tools character(20)
);


ALTER TABLE public.events OWNER TO upper;

--
-- Name: hire; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.hire (
    campaign_name character(32),
    employee_id integer
);


ALTER TABLE public.hire OWNER TO upper;

--
-- Name: memberof; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.memberof (
    campaign_name character(32),
    member_id integer
);


ALTER TABLE public.memberof OWNER TO upper;

--
-- Name: members; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.members (
    member_id integer NOT NULL,
    first_name character(20),
    last_name character(20),
    donate_amount real
);


ALTER TABLE public.members OWNER TO upper;

--
-- Name: participate; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.participate (
    event_name character(32),
    volunteer_id integer
);


ALTER TABLE public.participate OWNER TO upper;

--
-- Name: query1; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query1 AS
 SELECT members.first_name,
    members.last_name
   FROM public.members
  WHERE (members.donate_amount > (30000)::double precision);


ALTER TABLE public.query1 OWNER TO upper;

--
-- Name: query10; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query10 AS
 SELECT count(*) AS count
   FROM public.participate
  WHERE (participate.event_name = 'Save the trees'::bpchar);


ALTER TABLE public.query10 OWNER TO upper;

--
-- Name: query2; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query2 AS
 SELECT members.first_name,
    members.last_name
   FROM public.members
  WHERE (members.donate_amount >= ALL ( SELECT members_1.donate_amount
           FROM public.members members_1));


ALTER TABLE public.query2 OWNER TO upper;

--
-- Name: website; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.website (
    campaign_name character(32),
    push_time date,
    phase integer
);


ALTER TABLE public.website OWNER TO upper;

--
-- Name: query3; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query3 AS
 SELECT campaigns.campaign_name
   FROM public.campaigns,
    public.website
  WHERE ((campaigns.campaign_name = website.campaign_name) AND (campaigns.start_date = website.push_time));


ALTER TABLE public.query3 OWNER TO upper;

--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.volunteers (
    volunteer_id integer NOT NULL,
    first_name character(20),
    last_name character(20),
    tiers integer
);


ALTER TABLE public.volunteers OWNER TO upper;

--
-- Name: query4; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query4 AS
 SELECT volunteers.first_name,
    volunteers.last_name
   FROM (public.participate
     JOIN public.volunteers ON (((participate.volunteer_id = volunteers.volunteer_id) AND (participate.event_name = 'Save the dophins'::bpchar))));


ALTER TABLE public.query4 OWNER TO upper;

--
-- Name: query5; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query5 AS
 SELECT count(*) AS count
   FROM public.participate
  WHERE (participate.event_name = 'Bus life'::bpchar);


ALTER TABLE public.query5 OWNER TO upper;

--
-- Name: query6; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query6 AS
 SELECT h1.campaign_name
   FROM public.hire h1
  WHERE (NOT (EXISTS ( SELECT hire.campaign_name,
            hire.employee_id
           FROM public.hire
          WHERE ((hire.campaign_name = h1.campaign_name) AND (hire.employee_id <> h1.employee_id)))));


ALTER TABLE public.query6 OWNER TO upper;

--
-- Name: query7; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query7 AS
 SELECT participate.event_name
   FROM (public.volunteers
     JOIN public.participate ON (((volunteers.volunteer_id = participate.volunteer_id) AND (volunteers.volunteer_id = 88))));


ALTER TABLE public.query7 OWNER TO upper;

--
-- Name: query8; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query8 AS
 SELECT count(*) AS count
   FROM (public.volunteers
     JOIN public.participate ON (((volunteers.volunteer_id = participate.volunteer_id) AND (volunteers.first_name = 'Terry'::bpchar))));


ALTER TABLE public.query8 OWNER TO upper;

--
-- Name: query9; Type: VIEW; Schema: public; Owner: upper
--

CREATE VIEW public.query9 AS
 SELECT employees.first_name,
    employees.last_name
   FROM public.employees
  WHERE (employees.salary >= ALL ( SELECT employees_1.salary
           FROM public.employees employees_1));


ALTER TABLE public.query9 OWNER TO upper;

--
-- Name: run; Type: TABLE; Schema: public; Owner: upper
--

CREATE TABLE public.run (
    campaign_name character(32),
    event_name character(32)
);


ALTER TABLE public.run OWNER TO upper;

--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.campaigns (campaign_name, area, start_date, end_date, topic, budgets) FROM stdin;
Save the trees                  	Nanaimo             	2018-07-20	2018-07-25	forest              	500
Bike, don't drive               	Victoria            	2018-09-22	2018-10-10	air pollution       	1000
More vegetables, less meat      	Victoria            	2018-10-11	2018-10-25	food                	200
Bus life                        	Sannich             	2018-12-12	2018-12-20	air pollution       	500
No more killing                 	Nanaimo             	2018-12-25	2019-01-10	food                	900
Save the dophins                	Victoria            	2019-01-05	2019-02-20	animal              	1200
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.employees (employee_id, first_name, last_name, salary) FROM stdin;
133	Michael             	Hitchcock           	300
55	Norm                	Scully              	500
102	Kevin               	Cozner              	800
110	Doug                	Judy                	800
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.events (event_name, start_time, end_time, place, tools) FROM stdin;
Clean up the forest             	2018-07-20 10:00:00	2018-07-20 14:00:00	public squares      	posters             
Don't bother the animals        	2018-07-21 10:00:00	2018-07-21 18:00:00	street corner       	flyers              
Be active                       	2018-09-22 09:00:00	2018-09-22 15:00:00	street corner       	flyers              
red meat is not good            	2018-10-15 10:30:00	2018-10-16 18:00:00	public squares      	placards            
TEXT ANYTIME                    	2018-12-13 10:30:00	2018-12-20 18:00:00	public squares      	flyers              
Chicken wants to live           	2018-12-26 13:30:00	2018-12-28 18:00:00	public squares      	placards            
Dophins are so cute             	2019-01-06 15:30:00	2019-01-08 20:00:00	street corner       	posters             
\.


--
-- Data for Name: hire; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.hire (campaign_name, employee_id) FROM stdin;
Save the trees                  	133
Save the trees                  	55
Save the trees                  	110
Bike, don't drive               	133
Bike, don't drive               	102
Bike, don't drive               	55
More vegetables, less meat      	110
More vegetables, less meat      	55
Bus life                        	55
No more killing                 	55
No more killing                 	110
\.


--
-- Data for Name: memberof; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.memberof (campaign_name, member_id) FROM stdin;
Save the trees                  	65
Save the trees                  	255
Save the trees                  	783
Bike, don't drive               	133
Bike, don't drive               	65
Bike, don't drive               	255
More vegetables, less meat      	133
Bus life                        	65
Bus life                        	783
No more killing                 	783
No more killing                 	65
No more killing                 	133
Save the dophins                	65
Save the dophins                	255
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.members (member_id, first_name, last_name, donate_amount) FROM stdin;
65	John                	Kelly               	10000
255	Seamus              	Murphy              	40000
783	Keith               	Pembroke            	30000
550	Madeline            	Wuntch              	90000
\.


--
-- Data for Name: participate; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.participate (event_name, volunteer_id) FROM stdin;
Save the trees                  	88
Save the trees                  	176
Save the trees                  	122
Save the trees                  	100
Save the trees                  	165
Save the trees                  	201
Bike, don't drive               	88
Bike, don't drive               	122
Bike, don't drive               	100
Bike, don't drive               	165
More vegetables, less meat      	176
More vegetables, less meat      	165
Bus life                        	176
Bus life                        	122
Bus life                        	100
Bus life                        	165
Bus life                        	201
No more killing                 	88
No more killing                 	122
No more killing                 	165
Save the dophins                	88
Save the dophins                	176
Save the dophins                	122
Save the dophins                	165
Save the dophins                	201
\.


--
-- Data for Name: run; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.run (campaign_name, event_name) FROM stdin;
Save the trees                  	Clean up the forest             
Save the trees                  	Don't bother the animals        
Bike, don't drive               	Be active                       
More vegetables, less meat      	red meat is not good            
Bus life                        	TEXT ANYTIME                    
No more killing                 	Chicken wants to live           
Save the dophins                	Dophins are so cute             
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.volunteers (volunteer_id, first_name, last_name, tiers) FROM stdin;
176	Amy                 	Santigo             	1
88	Jake                	Peralta             	2
122	Gina                	Linetti             	1
100	Ray                 	Holt                	1
165	Charles             	Boyle               	2
201	Terry               	Jeffords            	1
\.


--
-- Data for Name: website; Type: TABLE DATA; Schema: public; Owner: upper
--

COPY public.website (campaign_name, push_time, phase) FROM stdin;
Save the trees                  	2018-07-20	3
Bike, don't drive               	2018-09-24	4
More vegetables, less meat      	2018-10-09	4
Bus life                        	2018-12-11	4
No more killing                 	2018-12-25	4
Save the dophins                	2019-01-05	4
\.


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: upper
--

ALTER TABLE ONLY public.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (campaign_name);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: upper
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: upper
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_name);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: upper
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: upper
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (volunteer_id);


--
-- Name: website website_campaign_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: upper
--

ALTER TABLE ONLY public.website
    ADD CONSTRAINT website_campaign_name_fkey FOREIGN KEY (campaign_name) REFERENCES public.campaigns(campaign_name);


--
-- PostgreSQL database dump complete
--

