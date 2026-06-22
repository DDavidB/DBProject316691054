--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1 (Debian 17.1-1.pgdg120+1)
-- Dumped by pg_dump version 17.1 (Debian 17.1-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    appointment_date date,
    start_time time without time zone,
    status character varying(20),
    patient_id integer,
    license_number integer
);


ALTER TABLE public.appointments OWNER TO admin;

--
-- Name: doctor_working_hours; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.doctor_working_hours (
    schedule_id integer NOT NULL,
    license_number integer,
    day_of_week character varying(15),
    start_time time without time zone,
    end_time time without time zone
);


ALTER TABLE public.doctor_working_hours OWNER TO admin;

--
-- Name: doctor_working_hours_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.doctor_working_hours_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doctor_working_hours_schedule_id_seq OWNER TO admin;

--
-- Name: doctor_working_hours_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.doctor_working_hours_schedule_id_seq OWNED BY public.doctor_working_hours.schedule_id;


--
-- Name: doctors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.doctors (
    license_number integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    specialization character varying(50),
    hire_date date
);


ALTER TABLE public.doctors OWNER TO admin;

--
-- Name: patients; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.patients (
    patient_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    birth_date date,
    gender character varying(50),
    phone character varying(20),
    email character varying(100),
    address character varying(255)
);


ALTER TABLE public.patients OWNER TO admin;

--
-- Name: payments; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    amount numeric(10,2),
    payment_date date,
    payment_method character varying(20),
    cardlast4 character varying(4),
    authcode character varying(20),
    receiptno character varying(50),
    patient_id integer
);


ALTER TABLE public.payments OWNER TO admin;

--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.prescriptions (
    prescription_id integer NOT NULL,
    medication_name character varying(100),
    dosage character varying(50),
    issue_date date,
    notes text,
    visit_id integer
);


ALTER TABLE public.prescriptions OWNER TO admin;

--
-- Name: visits_records; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.visits_records (
    visit_id integer NOT NULL,
    diagnosis text,
    doctor_notes text,
    temperature numeric(4,2),
    blood_pressure character varying(20),
    weight numeric(5,2),
    pulse integer,
    follow_up_needed character varying(10),
    appointment_id integer
);


ALTER TABLE public.visits_records OWNER TO admin;

--
-- Name: doctor_working_hours schedule_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.doctor_working_hours ALTER COLUMN schedule_id SET DEFAULT nextval('public.doctor_working_hours_schedule_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.appointments (appointment_id, appointment_date, start_time, status, patient_id, license_number) FROM stdin;
5001	2024-05-12	09:00:00	Completed	1	101
5002	2024-05-12	10:30:00	Completed	2	101
5003	2024-05-13	11:00:00	Scheduled	3	102
5000	2025-04-15	10:00:00	Completed	416	167
5004	2024-04-09	10:00:00	Completed	154	135
5005	2025-05-08	10:00:00	Completed	3	172
5006	2025-04-18	10:00:00	Completed	385	166
5007	2025-01-20	10:00:00	Completed	159	120
5008	2025-12-21	10:00:00	Completed	390	117
5009	2025-11-01	10:00:00	Completed	302	196
5010	2024-11-16	10:00:00	Completed	199	195
5011	2025-03-11	10:00:00	Completed	206	110
5012	2024-02-19	10:00:00	Completed	452	165
5013	2025-07-14	10:00:00	Completed	417	153
5014	2024-12-16	10:00:00	Completed	405	115
5015	2025-04-08	10:00:00	Completed	20	120
5016	2025-01-02	10:00:00	Completed	451	174
5017	2025-06-16	10:00:00	Completed	360	151
5018	2024-02-10	10:00:00	Completed	427	139
5019	2025-11-26	10:00:00	Completed	235	145
5020	2024-01-07	10:00:00	Completed	102	144
5021	2024-01-02	10:00:00	Completed	437	190
5022	2025-07-09	10:00:00	Completed	339	142
5023	2025-11-22	10:00:00	Completed	336	127
5024	2024-03-20	10:00:00	Completed	326	166
5025	2025-09-22	10:00:00	Completed	145	164
5026	2025-10-10	10:00:00	Completed	59	119
5027	2024-06-23	10:00:00	Completed	235	192
5028	2024-10-01	10:00:00	Completed	375	137
5029	2024-03-03	10:00:00	Completed	272	163
5030	2025-04-26	10:00:00	Completed	497	118
5031	2024-04-10	10:00:00	Completed	28	151
5032	2024-07-23	10:00:00	Completed	200	155
5033	2025-04-04	10:00:00	Completed	251	189
5034	2025-04-10	10:00:00	Completed	343	118
5035	2025-07-15	10:00:00	Completed	193	111
5036	2025-03-24	10:00:00	Completed	9	161
5037	2025-02-03	10:00:00	Completed	405	162
5038	2025-07-22	10:00:00	Completed	90	179
5039	2025-12-27	10:00:00	Completed	301	181
5040	2025-09-21	10:00:00	Completed	292	144
5041	2025-02-01	10:00:00	Completed	253	113
5042	2024-10-15	10:00:00	Completed	182	162
5043	2025-12-20	10:00:00	Completed	413	116
5044	2024-02-08	10:00:00	Completed	46	133
5045	2024-08-12	10:00:00	Completed	427	116
5046	2024-07-06	10:00:00	Completed	258	191
5047	2025-04-04	10:00:00	Completed	74	161
5048	2024-12-02	10:00:00	Completed	445	160
5049	2025-11-17	10:00:00	Completed	124	141
5050	2025-06-06	10:00:00	Completed	74	182
5051	2025-09-26	10:00:00	Completed	216	178
5052	2025-04-23	10:00:00	Completed	113	143
5053	2025-01-08	10:00:00	Completed	238	117
5054	2025-08-13	10:00:00	Completed	123	140
5055	2024-01-26	10:00:00	Completed	170	183
5056	2024-05-10	10:00:00	Completed	287	143
5057	2025-11-03	10:00:00	Completed	195	143
5058	2025-09-06	10:00:00	Completed	30	112
5059	2025-08-26	10:00:00	Completed	166	124
5060	2025-03-13	10:00:00	Completed	491	146
5061	2025-10-15	10:00:00	Completed	199	115
5062	2024-05-10	10:00:00	Completed	144	129
5063	2024-04-09	10:00:00	Completed	338	145
5064	2025-07-27	10:00:00	Completed	98	125
5065	2025-06-08	10:00:00	Completed	88	163
5066	2025-03-06	10:00:00	Completed	51	132
5067	2025-05-27	10:00:00	Completed	425	160
5068	2024-12-25	10:00:00	Completed	433	105
5069	2024-03-16	10:00:00	Completed	274	118
5070	2024-02-05	10:00:00	Completed	458	148
5071	2024-09-07	10:00:00	Completed	176	142
5072	2024-05-05	10:00:00	Completed	155	172
5073	2025-01-07	10:00:00	Completed	139	167
5074	2024-03-06	10:00:00	Completed	182	197
5075	2024-07-24	10:00:00	Completed	313	154
5076	2024-01-10	10:00:00	Completed	420	171
5077	2025-01-21	10:00:00	Completed	144	177
5078	2024-09-18	10:00:00	Completed	29	140
5079	2024-05-03	10:00:00	Completed	129	164
5080	2024-01-09	10:00:00	Completed	488	112
5081	2024-03-20	10:00:00	Completed	299	155
5082	2024-03-10	10:00:00	Completed	184	167
5083	2024-02-26	10:00:00	Completed	146	117
5084	2024-02-02	10:00:00	Completed	57	116
5085	2024-08-05	10:00:00	Completed	118	103
5086	2025-03-14	10:00:00	Completed	405	189
5087	2025-07-27	10:00:00	Completed	273	121
5088	2025-06-25	10:00:00	Completed	149	150
5089	2025-11-15	10:00:00	Completed	435	135
5090	2025-02-13	10:00:00	Completed	293	151
5091	2024-12-22	10:00:00	Completed	145	159
5092	2024-04-09	10:00:00	Completed	493	176
5093	2024-09-11	10:00:00	Completed	78	149
5094	2025-05-27	10:00:00	Completed	300	103
5095	2024-07-06	10:00:00	Completed	319	152
5096	2024-02-05	10:00:00	Completed	434	121
5097	2024-03-19	10:00:00	Completed	61	146
5098	2025-09-04	10:00:00	Completed	39	182
5099	2025-08-25	10:00:00	Completed	355	116
5100	2024-07-28	10:00:00	Completed	26	131
5101	2025-09-23	10:00:00	Completed	150	165
5102	2025-09-12	10:00:00	Completed	475	136
5103	2025-09-27	10:00:00	Completed	312	188
5104	2024-12-23	10:00:00	Completed	423	102
5105	2024-08-06	10:00:00	Completed	439	163
5106	2024-04-27	10:00:00	Completed	471	175
5107	2024-02-03	10:00:00	Completed	239	163
5108	2024-12-09	10:00:00	Completed	163	166
5109	2024-05-16	10:00:00	Completed	459	136
5110	2025-07-06	10:00:00	Completed	396	140
5111	2024-05-26	10:00:00	Completed	123	175
5112	2024-02-21	10:00:00	Completed	25	161
5113	2025-11-12	10:00:00	Completed	100	106
5114	2025-02-01	10:00:00	Completed	208	200
5115	2025-09-07	10:00:00	Completed	437	187
5116	2024-04-16	10:00:00	Completed	53	184
5117	2025-10-15	10:00:00	Completed	107	118
5118	2025-01-05	10:00:00	Completed	467	175
5119	2025-05-12	10:00:00	Completed	44	168
5120	2025-09-12	10:00:00	Completed	390	161
5121	2024-06-27	10:00:00	Completed	86	152
5122	2024-01-05	10:00:00	Completed	402	134
5123	2024-08-14	10:00:00	Completed	448	104
5124	2024-10-26	10:00:00	Completed	187	142
5125	2024-03-11	10:00:00	Completed	87	169
5126	2024-01-03	10:00:00	Completed	408	128
5127	2025-05-12	10:00:00	Completed	184	155
5128	2025-04-10	10:00:00	Completed	268	119
5129	2025-12-28	10:00:00	Completed	423	197
5130	2024-04-24	10:00:00	Completed	82	170
5131	2024-05-07	10:00:00	Completed	212	135
5132	2024-04-25	10:00:00	Completed	178	108
5133	2024-06-25	10:00:00	Completed	204	192
5134	2024-09-22	10:00:00	Completed	417	113
5135	2024-12-17	10:00:00	Completed	303	195
5136	2024-01-02	10:00:00	Completed	235	150
5137	2025-05-05	10:00:00	Completed	443	174
5138	2025-06-28	10:00:00	Completed	349	184
5139	2025-02-20	10:00:00	Completed	413	137
5140	2025-10-25	10:00:00	Completed	282	118
5141	2025-07-17	10:00:00	Completed	308	161
5142	2025-08-19	10:00:00	Completed	269	118
5143	2024-06-25	10:00:00	Completed	431	160
5144	2024-03-06	10:00:00	Completed	485	146
5145	2025-09-15	10:00:00	Completed	248	160
5146	2025-02-20	10:00:00	Completed	128	101
5147	2025-02-28	10:00:00	Completed	274	125
5148	2025-09-14	10:00:00	Completed	355	168
5149	2025-12-20	10:00:00	Completed	219	101
5150	2024-08-20	10:00:00	Completed	428	179
5151	2025-02-01	10:00:00	Completed	227	134
5152	2025-04-23	10:00:00	Completed	52	102
5153	2024-04-05	10:00:00	Completed	227	194
5154	2025-05-20	10:00:00	Completed	214	115
5155	2025-12-09	10:00:00	Completed	338	152
5156	2024-03-20	10:00:00	Completed	289	103
5157	2024-01-24	10:00:00	Completed	347	146
5158	2024-01-11	10:00:00	Completed	97	160
5159	2024-11-12	10:00:00	Completed	36	163
5160	2024-04-08	10:00:00	Completed	61	108
5161	2024-07-22	10:00:00	Completed	345	160
5162	2024-08-13	10:00:00	Completed	378	167
5163	2025-10-07	10:00:00	Completed	377	103
5164	2024-02-10	10:00:00	Completed	251	136
5165	2025-05-17	10:00:00	Completed	332	122
5166	2024-06-25	10:00:00	Completed	412	166
5167	2025-04-20	10:00:00	Completed	178	181
5168	2025-03-06	10:00:00	Completed	125	176
5169	2025-07-26	10:00:00	Completed	252	155
5170	2024-07-08	10:00:00	Completed	149	116
5171	2024-10-28	10:00:00	Completed	347	126
5172	2024-11-22	10:00:00	Completed	71	118
5173	2025-09-02	10:00:00	Completed	492	122
5174	2024-10-17	10:00:00	Completed	187	149
5175	2025-05-19	10:00:00	Completed	211	121
5176	2024-04-23	10:00:00	Completed	363	129
5177	2025-10-05	10:00:00	Completed	471	174
5178	2024-04-02	10:00:00	Completed	136	167
5179	2024-09-12	10:00:00	Completed	476	161
5180	2024-01-13	10:00:00	Completed	485	157
5181	2025-09-21	10:00:00	Completed	422	175
5182	2024-03-08	10:00:00	Completed	282	153
5183	2025-10-28	10:00:00	Completed	444	117
5184	2025-12-28	10:00:00	Completed	488	145
5185	2025-11-03	10:00:00	Completed	434	179
5186	2024-11-27	10:00:00	Completed	272	128
5187	2025-10-13	10:00:00	Completed	103	134
5188	2025-11-04	10:00:00	Completed	201	142
5189	2024-03-11	10:00:00	Completed	29	114
5190	2024-01-26	10:00:00	Completed	341	167
5191	2025-12-15	10:00:00	Completed	181	170
5192	2024-02-28	10:00:00	Completed	499	167
5193	2024-12-20	10:00:00	Completed	160	158
5194	2025-10-05	10:00:00	Completed	178	112
5195	2024-09-18	10:00:00	Completed	80	185
5196	2025-09-11	10:00:00	Completed	452	186
5197	2024-04-14	10:00:00	Completed	138	196
5198	2025-05-06	10:00:00	Completed	126	152
5199	2025-12-20	10:00:00	Completed	113	118
5200	2024-10-12	10:00:00	Completed	357	164
5201	2024-11-01	10:00:00	Completed	253	179
5202	2025-03-07	10:00:00	Completed	377	166
5203	2024-04-07	10:00:00	Completed	235	163
5204	2024-08-06	10:00:00	Completed	431	163
5205	2025-02-22	10:00:00	Completed	245	147
5206	2024-04-05	10:00:00	Completed	452	199
5207	2024-02-06	10:00:00	Completed	374	125
5208	2025-11-23	10:00:00	Completed	445	140
5209	2025-01-27	10:00:00	Completed	104	127
5210	2025-07-13	10:00:00	Completed	284	119
5211	2024-07-27	10:00:00	Completed	384	194
5212	2024-02-21	10:00:00	Completed	346	140
5213	2025-10-12	10:00:00	Completed	400	162
5214	2024-11-23	10:00:00	Completed	67	120
5215	2025-06-12	10:00:00	Completed	114	151
5216	2025-08-03	10:00:00	Completed	289	172
5217	2024-10-26	10:00:00	Completed	480	193
5218	2025-01-06	10:00:00	Completed	386	152
5219	2024-09-17	10:00:00	Completed	40	180
5220	2025-05-09	10:00:00	Completed	242	183
5221	2025-09-24	10:00:00	Completed	262	106
5222	2025-07-23	10:00:00	Completed	375	196
5223	2025-12-02	10:00:00	Completed	446	113
5224	2024-01-23	10:00:00	Completed	9	172
5225	2024-09-05	10:00:00	Completed	462	102
5226	2025-03-18	10:00:00	Completed	125	150
5227	2024-09-08	10:00:00	Completed	118	194
5228	2024-04-08	10:00:00	Completed	498	153
5229	2024-04-25	10:00:00	Completed	49	144
5230	2025-12-03	10:00:00	Completed	282	139
5231	2025-04-17	10:00:00	Completed	309	136
5232	2024-03-09	10:00:00	Completed	489	174
5233	2024-03-08	10:00:00	Completed	397	181
5234	2025-03-05	10:00:00	Completed	458	141
5235	2024-07-27	10:00:00	Completed	312	128
5236	2025-06-15	10:00:00	Completed	432	156
5237	2025-10-26	10:00:00	Completed	278	175
5238	2025-11-03	10:00:00	Completed	346	118
5239	2024-02-15	10:00:00	Completed	425	188
5240	2024-05-12	10:00:00	Completed	103	103
5241	2025-07-06	10:00:00	Completed	423	114
5242	2025-07-07	10:00:00	Completed	357	153
5243	2024-10-03	10:00:00	Completed	121	189
5244	2025-10-03	10:00:00	Completed	229	118
5245	2025-07-24	10:00:00	Completed	368	167
5246	2024-07-28	10:00:00	Completed	69	114
5247	2024-08-19	10:00:00	Completed	57	200
5248	2024-10-12	10:00:00	Completed	390	143
5249	2025-04-15	10:00:00	Completed	305	196
5250	2025-11-10	10:00:00	Completed	48	123
5251	2025-11-07	10:00:00	Completed	187	115
5252	2025-07-26	10:00:00	Completed	204	102
5253	2025-02-27	10:00:00	Completed	303	191
5254	2025-09-28	10:00:00	Completed	231	200
5255	2024-07-08	10:00:00	Completed	94	157
5256	2025-05-08	10:00:00	Completed	114	112
5257	2025-01-28	10:00:00	Completed	102	158
5258	2024-11-14	10:00:00	Completed	4	190
5259	2024-11-19	10:00:00	Completed	358	193
5260	2025-08-08	10:00:00	Completed	417	153
5261	2025-04-21	10:00:00	Completed	72	192
5262	2025-04-01	10:00:00	Completed	223	115
5263	2025-07-23	10:00:00	Completed	99	149
5264	2025-01-06	10:00:00	Completed	167	117
5265	2025-08-04	10:00:00	Completed	432	114
5266	2025-06-01	10:00:00	Completed	424	150
5267	2024-11-21	10:00:00	Completed	294	102
5268	2024-09-23	10:00:00	Completed	202	183
5269	2025-04-27	10:00:00	Completed	492	197
5270	2025-01-27	10:00:00	Completed	63	145
5271	2025-12-13	10:00:00	Completed	190	105
5272	2024-06-05	10:00:00	Completed	91	187
5273	2025-07-14	10:00:00	Completed	244	195
5274	2024-12-12	10:00:00	Completed	6	111
5275	2025-11-25	10:00:00	Completed	400	161
5276	2024-11-02	10:00:00	Completed	371	122
5277	2025-06-15	10:00:00	Completed	400	175
5278	2024-09-03	10:00:00	Completed	469	110
5279	2024-07-06	10:00:00	Completed	466	183
5280	2024-02-14	10:00:00	Completed	123	113
5281	2024-07-27	10:00:00	Completed	206	107
5282	2024-10-02	10:00:00	Completed	298	144
5283	2025-03-14	10:00:00	Completed	14	159
5284	2025-03-19	10:00:00	Completed	321	111
5285	2024-12-07	10:00:00	Completed	398	163
5286	2025-01-24	10:00:00	Completed	421	156
5287	2024-09-16	10:00:00	Completed	362	174
5288	2024-11-15	10:00:00	Completed	138	168
5289	2024-08-01	10:00:00	Completed	440	192
5290	2024-08-14	10:00:00	Completed	481	187
5291	2025-09-10	10:00:00	Completed	245	112
5292	2025-01-23	10:00:00	Completed	300	174
5293	2024-05-10	10:00:00	Completed	119	104
5294	2024-08-18	10:00:00	Completed	93	143
5295	2024-12-26	10:00:00	Completed	72	151
5296	2024-09-03	10:00:00	Completed	223	163
5297	2024-01-24	10:00:00	Completed	480	107
5298	2024-12-03	10:00:00	Completed	201	179
5299	2024-03-26	10:00:00	Completed	328	185
5300	2025-09-03	10:00:00	Completed	54	194
5301	2024-12-06	10:00:00	Completed	114	113
5302	2025-11-20	10:00:00	Completed	432	190
5303	2025-03-14	10:00:00	Completed	155	188
5304	2024-05-19	10:00:00	Completed	372	171
5305	2025-04-15	10:00:00	Completed	459	163
5306	2025-10-07	10:00:00	Completed	184	135
5307	2025-01-21	10:00:00	Completed	335	176
5308	2024-11-06	10:00:00	Completed	359	176
5309	2025-10-08	10:00:00	Completed	442	178
5310	2024-08-27	10:00:00	Completed	75	163
5311	2025-04-15	10:00:00	Completed	92	187
5312	2024-11-12	10:00:00	Completed	267	131
5313	2025-11-09	10:00:00	Completed	267	138
5314	2025-02-12	10:00:00	Completed	447	182
5315	2024-03-27	10:00:00	Completed	370	127
5316	2024-07-21	10:00:00	Completed	280	125
5317	2025-05-25	10:00:00	Completed	450	175
5318	2024-03-19	10:00:00	Completed	218	195
5319	2025-03-06	10:00:00	Completed	283	145
5320	2024-05-05	10:00:00	Completed	224	174
5321	2024-11-20	10:00:00	Completed	265	101
5322	2024-01-01	10:00:00	Completed	19	144
5323	2025-04-20	10:00:00	Completed	467	106
5324	2024-09-11	10:00:00	Completed	372	200
5325	2025-10-01	10:00:00	Completed	31	120
5326	2024-03-24	10:00:00	Completed	154	178
5327	2025-01-22	10:00:00	Completed	6	132
5328	2024-11-26	10:00:00	Completed	170	112
5329	2025-08-02	10:00:00	Completed	248	184
5330	2025-10-03	10:00:00	Completed	417	123
5331	2025-05-08	10:00:00	Completed	269	116
5332	2024-12-11	10:00:00	Completed	221	130
5333	2024-10-09	10:00:00	Completed	411	198
5334	2025-12-14	10:00:00	Completed	404	107
5335	2024-03-15	10:00:00	Completed	268	147
5336	2024-05-25	10:00:00	Completed	184	101
5337	2025-12-14	10:00:00	Completed	122	133
5338	2025-07-14	10:00:00	Completed	401	184
5339	2024-02-16	10:00:00	Completed	461	107
5340	2025-07-05	10:00:00	Completed	485	112
5341	2025-10-16	10:00:00	Completed	476	145
5342	2024-08-07	10:00:00	Completed	486	140
5343	2025-07-08	10:00:00	Completed	464	162
5344	2025-01-19	10:00:00	Completed	311	127
5345	2024-04-09	10:00:00	Completed	98	126
5346	2025-10-22	10:00:00	Completed	125	120
5347	2025-01-28	10:00:00	Completed	140	141
5348	2024-05-02	10:00:00	Completed	9	109
5349	2024-06-21	10:00:00	Completed	445	189
5350	2024-09-10	10:00:00	Completed	265	182
5351	2025-01-07	10:00:00	Completed	444	132
5352	2025-03-15	10:00:00	Completed	334	128
5353	2024-11-22	10:00:00	Completed	292	139
5354	2025-02-02	10:00:00	Completed	270	182
5355	2025-11-18	10:00:00	Completed	436	170
5356	2024-08-10	10:00:00	Completed	107	144
5357	2025-03-01	10:00:00	Completed	51	137
5358	2024-08-17	10:00:00	Completed	60	141
5359	2024-09-10	10:00:00	Completed	134	185
5360	2025-02-14	10:00:00	Completed	386	179
5361	2025-10-23	10:00:00	Completed	366	169
5362	2024-10-17	10:00:00	Completed	193	185
5363	2025-04-12	10:00:00	Completed	37	169
5364	2025-02-13	10:00:00	Completed	204	116
5365	2024-02-10	10:00:00	Completed	108	192
5366	2024-12-27	10:00:00	Completed	5	137
5367	2025-01-28	10:00:00	Completed	411	198
5368	2025-04-03	10:00:00	Completed	227	125
5369	2024-05-23	10:00:00	Completed	346	192
5370	2024-06-24	10:00:00	Completed	300	143
5371	2025-06-13	10:00:00	Completed	270	172
5372	2024-05-08	10:00:00	Completed	306	143
5373	2024-06-03	10:00:00	Completed	181	179
5374	2024-11-07	10:00:00	Completed	221	159
5375	2025-06-26	10:00:00	Completed	235	119
5376	2025-11-11	10:00:00	Completed	205	183
5377	2025-02-23	10:00:00	Completed	4	174
5378	2024-09-07	10:00:00	Completed	418	120
5379	2024-01-13	10:00:00	Completed	411	163
5380	2025-06-09	10:00:00	Completed	262	200
5381	2024-06-09	10:00:00	Completed	17	198
5382	2024-11-10	10:00:00	Completed	495	162
5383	2024-02-09	10:00:00	Completed	145	105
5384	2025-10-01	10:00:00	Completed	486	109
5385	2024-05-15	10:00:00	Completed	216	108
5386	2024-01-24	10:00:00	Completed	469	168
5387	2024-07-22	10:00:00	Completed	419	190
5388	2025-02-09	10:00:00	Completed	27	148
5389	2024-09-24	10:00:00	Completed	70	101
5390	2024-03-21	10:00:00	Completed	434	176
5391	2025-10-03	10:00:00	Completed	247	103
5392	2024-08-08	10:00:00	Completed	396	154
5393	2025-12-27	10:00:00	Completed	437	168
5394	2024-02-22	10:00:00	Completed	211	116
5395	2024-02-18	10:00:00	Completed	45	176
5396	2025-04-04	10:00:00	Completed	325	102
5397	2025-03-20	10:00:00	Completed	180	164
5398	2025-03-05	10:00:00	Completed	385	168
5399	2025-04-09	10:00:00	Completed	157	189
5400	2025-12-11	10:00:00	Completed	172	128
5401	2025-11-21	10:00:00	Completed	109	180
5402	2024-07-23	10:00:00	Completed	148	113
5403	2024-09-21	10:00:00	Completed	298	121
5404	2024-07-01	10:00:00	Completed	118	188
5405	2025-09-05	10:00:00	Completed	489	123
5406	2024-06-03	10:00:00	Completed	39	184
5407	2024-01-01	10:00:00	Completed	373	126
5408	2024-08-22	10:00:00	Completed	213	192
5409	2024-04-12	10:00:00	Completed	27	192
5410	2024-12-05	10:00:00	Completed	344	154
5411	2024-06-02	10:00:00	Completed	100	180
5412	2024-12-21	10:00:00	Completed	239	104
5413	2024-09-23	10:00:00	Completed	14	142
5414	2025-05-24	10:00:00	Completed	145	192
5415	2025-12-17	10:00:00	Completed	206	146
5416	2025-03-21	10:00:00	Completed	487	118
5417	2025-02-05	10:00:00	Completed	229	163
5418	2025-11-13	10:00:00	Completed	293	197
5419	2024-11-06	10:00:00	Completed	328	196
5420	2024-07-25	10:00:00	Completed	465	180
5421	2025-04-11	10:00:00	Completed	331	172
5422	2024-03-20	10:00:00	Completed	272	101
5423	2025-12-15	10:00:00	Completed	363	197
5424	2024-09-16	10:00:00	Completed	310	143
5425	2025-05-20	10:00:00	Completed	23	193
5426	2025-07-06	10:00:00	Completed	155	117
5427	2024-06-24	10:00:00	Completed	486	114
5428	2024-12-15	10:00:00	Completed	182	133
5429	2025-05-04	10:00:00	Completed	127	139
5430	2024-08-20	10:00:00	Completed	311	170
5431	2025-12-27	10:00:00	Completed	51	180
5432	2025-01-14	10:00:00	Completed	469	120
5433	2024-02-28	10:00:00	Completed	110	112
5434	2025-03-16	10:00:00	Completed	129	150
5435	2025-11-27	10:00:00	Completed	418	149
5436	2025-07-22	10:00:00	Completed	83	170
5437	2025-07-16	10:00:00	Completed	374	121
5438	2024-12-10	10:00:00	Completed	157	121
5439	2025-05-03	10:00:00	Completed	90	191
5440	2024-08-13	10:00:00	Completed	5	149
5441	2024-06-25	10:00:00	Completed	29	119
5442	2025-07-01	10:00:00	Completed	221	124
5443	2025-02-27	10:00:00	Completed	149	185
5444	2025-03-24	10:00:00	Completed	41	187
5445	2024-07-16	10:00:00	Completed	429	115
5446	2024-11-11	10:00:00	Completed	143	130
5447	2025-07-10	10:00:00	Completed	287	173
5448	2025-05-08	10:00:00	Completed	193	167
5449	2025-10-10	10:00:00	Completed	462	196
5450	2025-10-14	10:00:00	Completed	205	150
5451	2024-02-20	10:00:00	Completed	348	137
5452	2024-06-27	10:00:00	Completed	497	142
5453	2024-01-09	10:00:00	Completed	174	147
5454	2025-04-17	10:00:00	Completed	365	121
5455	2025-08-20	10:00:00	Completed	353	101
5456	2024-02-22	10:00:00	Completed	48	124
5457	2024-05-04	10:00:00	Completed	460	121
5458	2025-12-13	10:00:00	Completed	16	164
5459	2024-07-02	10:00:00	Completed	266	107
5460	2025-12-09	10:00:00	Completed	380	193
5461	2025-01-17	10:00:00	Completed	66	171
5462	2025-02-24	10:00:00	Completed	82	177
5463	2024-05-26	10:00:00	Completed	20	121
5464	2025-10-04	10:00:00	Completed	359	142
5465	2024-09-10	10:00:00	Completed	280	152
5466	2024-08-16	10:00:00	Completed	228	167
5467	2025-09-04	10:00:00	Completed	130	115
5468	2024-05-18	10:00:00	Completed	134	118
5469	2024-07-24	10:00:00	Completed	134	133
5470	2024-02-05	10:00:00	Completed	41	163
5471	2024-09-19	10:00:00	Completed	208	152
5472	2025-10-25	10:00:00	Completed	433	183
5473	2024-03-16	10:00:00	Completed	139	147
5474	2024-10-13	10:00:00	Completed	140	119
5475	2024-06-24	10:00:00	Completed	340	113
5476	2024-10-23	10:00:00	Completed	165	137
5477	2025-05-25	10:00:00	Completed	314	155
5478	2024-08-22	10:00:00	Completed	166	113
5479	2025-04-17	10:00:00	Completed	136	200
5480	2024-11-24	10:00:00	Completed	77	185
5481	2024-08-20	10:00:00	Completed	197	191
5482	2024-01-07	10:00:00	Completed	397	143
5483	2024-01-08	10:00:00	Completed	465	108
5484	2025-02-11	10:00:00	Completed	373	197
5485	2024-11-16	10:00:00	Completed	19	129
5486	2025-02-15	10:00:00	Completed	225	144
5487	2025-03-18	10:00:00	Completed	364	158
5488	2025-01-05	10:00:00	Completed	226	112
5489	2025-08-21	10:00:00	Completed	181	142
5490	2024-04-01	10:00:00	Completed	335	103
5491	2025-11-20	10:00:00	Completed	438	150
5492	2025-03-12	10:00:00	Completed	273	150
5493	2025-11-07	10:00:00	Completed	160	121
5494	2024-11-03	10:00:00	Completed	490	134
5495	2024-07-14	10:00:00	Completed	446	197
5496	2024-07-15	10:00:00	Completed	422	196
5497	2024-06-01	10:00:00	Completed	134	171
5498	2024-07-18	10:00:00	Completed	227	167
5499	2025-08-11	10:00:00	Completed	86	152
\.


--
-- Data for Name: doctor_working_hours; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.doctor_working_hours (schedule_id, license_number, day_of_week, start_time, end_time) FROM stdin;
1	101	Sunday	08:00:00	14:00:00
2	101	Tuesday	12:00:00	18:00:00
3	102	Monday	09:00:00	15:00:00
4	102	Thursday	10:00:00	16:00:00
5	101	Friday	08:00:00	16:00:00
6	101	Thursday	08:00:00	16:00:00
7	102	Sunday	08:00:00	16:00:00
8	103	Monday	08:00:00	16:00:00
9	103	Tuesday	08:00:00	16:00:00
10	103	Sunday	08:00:00	16:00:00
11	104	Wednesday	08:00:00	16:00:00
12	104	Tuesday	08:00:00	16:00:00
13	104	Friday	08:00:00	16:00:00
14	105	Sunday	08:00:00	16:00:00
15	105	Friday	08:00:00	16:00:00
16	106	Thursday	08:00:00	16:00:00
17	107	Thursday	08:00:00	16:00:00
18	108	Wednesday	08:00:00	16:00:00
19	108	Tuesday	08:00:00	16:00:00
20	109	Wednesday	08:00:00	16:00:00
21	110	Sunday	08:00:00	16:00:00
22	111	Thursday	08:00:00	16:00:00
23	112	Sunday	08:00:00	16:00:00
24	112	Wednesday	08:00:00	16:00:00
25	113	Wednesday	08:00:00	16:00:00
26	114	Thursday	08:00:00	16:00:00
27	114	Wednesday	08:00:00	16:00:00
28	115	Tuesday	08:00:00	16:00:00
29	116	Thursday	08:00:00	16:00:00
30	116	Monday	08:00:00	16:00:00
31	116	Wednesday	08:00:00	16:00:00
32	117	Thursday	08:00:00	16:00:00
33	118	Sunday	08:00:00	16:00:00
34	118	Wednesday	08:00:00	16:00:00
35	119	Tuesday	08:00:00	16:00:00
36	119	Thursday	08:00:00	16:00:00
37	120	Tuesday	08:00:00	16:00:00
38	121	Monday	08:00:00	16:00:00
39	122	Friday	08:00:00	16:00:00
40	122	Tuesday	08:00:00	16:00:00
41	123	Tuesday	08:00:00	16:00:00
42	123	Sunday	08:00:00	16:00:00
43	123	Thursday	08:00:00	16:00:00
44	124	Tuesday	08:00:00	16:00:00
45	124	Monday	08:00:00	16:00:00
46	124	Friday	08:00:00	16:00:00
47	125	Monday	08:00:00	16:00:00
48	125	Sunday	08:00:00	16:00:00
49	125	Wednesday	08:00:00	16:00:00
50	126	Tuesday	08:00:00	16:00:00
51	126	Friday	08:00:00	16:00:00
52	127	Wednesday	08:00:00	16:00:00
53	127	Sunday	08:00:00	16:00:00
54	128	Thursday	08:00:00	16:00:00
55	129	Thursday	08:00:00	16:00:00
56	129	Tuesday	08:00:00	16:00:00
57	130	Thursday	08:00:00	16:00:00
58	131	Tuesday	08:00:00	16:00:00
59	132	Wednesday	08:00:00	16:00:00
60	132	Monday	08:00:00	16:00:00
61	133	Thursday	08:00:00	16:00:00
62	133	Friday	08:00:00	16:00:00
63	134	Tuesday	08:00:00	16:00:00
64	134	Wednesday	08:00:00	16:00:00
65	135	Tuesday	08:00:00	16:00:00
66	135	Wednesday	08:00:00	16:00:00
67	136	Friday	08:00:00	16:00:00
68	137	Friday	08:00:00	16:00:00
69	137	Thursday	08:00:00	16:00:00
70	138	Thursday	08:00:00	16:00:00
71	138	Monday	08:00:00	16:00:00
72	139	Friday	08:00:00	16:00:00
73	139	Thursday	08:00:00	16:00:00
74	140	Sunday	08:00:00	16:00:00
75	140	Friday	08:00:00	16:00:00
76	141	Wednesday	08:00:00	16:00:00
77	142	Tuesday	08:00:00	16:00:00
78	143	Thursday	08:00:00	16:00:00
79	144	Monday	08:00:00	16:00:00
80	145	Wednesday	08:00:00	16:00:00
81	145	Friday	08:00:00	16:00:00
82	146	Thursday	08:00:00	16:00:00
83	147	Tuesday	08:00:00	16:00:00
84	147	Wednesday	08:00:00	16:00:00
85	148	Monday	08:00:00	16:00:00
86	148	Friday	08:00:00	16:00:00
87	148	Thursday	08:00:00	16:00:00
88	149	Sunday	08:00:00	16:00:00
89	149	Thursday	08:00:00	16:00:00
90	150	Sunday	08:00:00	16:00:00
91	151	Friday	08:00:00	16:00:00
92	152	Friday	08:00:00	16:00:00
93	153	Monday	08:00:00	16:00:00
94	153	Sunday	08:00:00	16:00:00
95	154	Friday	08:00:00	16:00:00
96	154	Monday	08:00:00	16:00:00
97	155	Sunday	08:00:00	16:00:00
98	155	Wednesday	08:00:00	16:00:00
99	155	Thursday	08:00:00	16:00:00
100	156	Wednesday	08:00:00	16:00:00
101	156	Monday	08:00:00	16:00:00
102	156	Tuesday	08:00:00	16:00:00
103	157	Tuesday	08:00:00	16:00:00
104	157	Monday	08:00:00	16:00:00
105	158	Wednesday	08:00:00	16:00:00
106	158	Friday	08:00:00	16:00:00
107	158	Thursday	08:00:00	16:00:00
108	159	Tuesday	08:00:00	16:00:00
109	159	Friday	08:00:00	16:00:00
110	159	Monday	08:00:00	16:00:00
111	160	Friday	08:00:00	16:00:00
112	160	Tuesday	08:00:00	16:00:00
113	161	Thursday	08:00:00	16:00:00
114	162	Monday	08:00:00	16:00:00
115	162	Tuesday	08:00:00	16:00:00
116	163	Monday	08:00:00	16:00:00
117	163	Sunday	08:00:00	16:00:00
118	164	Thursday	08:00:00	16:00:00
119	165	Monday	08:00:00	16:00:00
120	165	Sunday	08:00:00	16:00:00
121	166	Monday	08:00:00	16:00:00
122	167	Tuesday	08:00:00	16:00:00
123	168	Friday	08:00:00	16:00:00
124	168	Wednesday	08:00:00	16:00:00
125	169	Tuesday	08:00:00	16:00:00
126	169	Wednesday	08:00:00	16:00:00
127	170	Friday	08:00:00	16:00:00
128	171	Sunday	08:00:00	16:00:00
129	171	Friday	08:00:00	16:00:00
130	171	Wednesday	08:00:00	16:00:00
131	172	Thursday	08:00:00	16:00:00
132	173	Wednesday	08:00:00	16:00:00
133	174	Friday	08:00:00	16:00:00
134	174	Monday	08:00:00	16:00:00
135	174	Wednesday	08:00:00	16:00:00
136	175	Wednesday	08:00:00	16:00:00
137	175	Tuesday	08:00:00	16:00:00
138	176	Wednesday	08:00:00	16:00:00
139	176	Monday	08:00:00	16:00:00
140	176	Friday	08:00:00	16:00:00
141	177	Monday	08:00:00	16:00:00
142	177	Thursday	08:00:00	16:00:00
143	178	Monday	08:00:00	16:00:00
144	178	Thursday	08:00:00	16:00:00
145	179	Friday	08:00:00	16:00:00
146	180	Monday	08:00:00	16:00:00
147	180	Sunday	08:00:00	16:00:00
148	181	Monday	08:00:00	16:00:00
149	181	Wednesday	08:00:00	16:00:00
150	181	Friday	08:00:00	16:00:00
151	182	Thursday	08:00:00	16:00:00
152	183	Thursday	08:00:00	16:00:00
153	184	Friday	08:00:00	16:00:00
154	184	Monday	08:00:00	16:00:00
155	184	Tuesday	08:00:00	16:00:00
156	185	Wednesday	08:00:00	16:00:00
157	185	Friday	08:00:00	16:00:00
158	185	Tuesday	08:00:00	16:00:00
159	186	Monday	08:00:00	16:00:00
160	186	Wednesday	08:00:00	16:00:00
161	186	Friday	08:00:00	16:00:00
162	187	Sunday	08:00:00	16:00:00
163	187	Friday	08:00:00	16:00:00
164	187	Monday	08:00:00	16:00:00
165	188	Thursday	08:00:00	16:00:00
166	189	Thursday	08:00:00	16:00:00
167	189	Tuesday	08:00:00	16:00:00
168	190	Friday	08:00:00	16:00:00
169	190	Sunday	08:00:00	16:00:00
170	190	Tuesday	08:00:00	16:00:00
171	191	Sunday	08:00:00	16:00:00
172	191	Tuesday	08:00:00	16:00:00
173	191	Friday	08:00:00	16:00:00
174	192	Wednesday	08:00:00	16:00:00
175	192	Thursday	08:00:00	16:00:00
176	193	Tuesday	08:00:00	16:00:00
177	193	Monday	08:00:00	16:00:00
178	194	Tuesday	08:00:00	16:00:00
179	194	Thursday	08:00:00	16:00:00
180	194	Sunday	08:00:00	16:00:00
181	195	Monday	08:00:00	16:00:00
182	195	Tuesday	08:00:00	16:00:00
183	195	Wednesday	08:00:00	16:00:00
184	196	Tuesday	08:00:00	16:00:00
185	196	Friday	08:00:00	16:00:00
186	196	Thursday	08:00:00	16:00:00
187	197	Sunday	08:00:00	16:00:00
188	198	Friday	08:00:00	16:00:00
189	199	Friday	08:00:00	16:00:00
190	199	Wednesday	08:00:00	16:00:00
191	199	Sunday	08:00:00	16:00:00
192	200	Sunday	08:00:00	16:00:00
193	200	Tuesday	08:00:00	16:00:00
\.


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.doctors (license_number, first_name, last_name, specialization, hire_date) FROM stdin;
101	╫ף"╫¿ ╫¿╫ץ╫¬	╫נ╫ס╫¿╫פ╫¥	Cardiology	2015-06-01
102	╫ף"╫¿ ╫נ╫£╫ץ╫ƒ	╫₧╫צ╫¿╫ק╫ש	Orthopedics	2018-02-15
103	Dr_103	DocLast	Pediatrics	2015-10-09
104	Dr_104	DocLast	General	2017-02-25
105	Dr_105	DocLast	Pediatrics	2018-01-09
106	Dr_106	DocLast	Pediatrics	2013-06-24
107	Dr_107	DocLast	Pediatrics	2013-02-28
108	Dr_108	DocLast	General	2010-07-09
109	Dr_109	DocLast	Orthopedics	2019-10-05
110	Dr_110	DocLast	Orthopedics	2011-03-12
111	Dr_111	DocLast	Cardiology	2019-03-17
112	Dr_112	DocLast	Cardiology	2020-05-04
113	Dr_113	DocLast	Pediatrics	2013-11-18
114	Dr_114	DocLast	General	2018-11-18
115	Dr_115	DocLast	Pediatrics	2013-04-26
116	Dr_116	DocLast	Cardiology	2024-05-15
117	Dr_117	DocLast	Orthopedics	2023-04-21
118	Dr_118	DocLast	General	2020-09-20
119	Dr_119	DocLast	General	2017-09-18
120	Dr_120	DocLast	Cardiology	2015-05-26
121	Dr_121	DocLast	Orthopedics	2018-10-19
122	Dr_122	DocLast	Orthopedics	2022-04-25
123	Dr_123	DocLast	Cardiology	2018-01-09
124	Dr_124	DocLast	Pediatrics	2015-04-28
125	Dr_125	DocLast	Cardiology	2012-10-04
126	Dr_126	DocLast	Cardiology	2015-07-19
127	Dr_127	DocLast	Cardiology	2024-10-15
128	Dr_128	DocLast	Cardiology	2023-07-25
129	Dr_129	DocLast	Cardiology	2014-06-11
130	Dr_130	DocLast	Orthopedics	2011-09-24
131	Dr_131	DocLast	Pediatrics	2019-01-12
132	Dr_132	DocLast	Cardiology	2017-02-03
133	Dr_133	DocLast	Pediatrics	2023-04-16
134	Dr_134	DocLast	Cardiology	2022-09-28
135	Dr_135	DocLast	Cardiology	2011-01-07
136	Dr_136	DocLast	Pediatrics	2013-01-21
137	Dr_137	DocLast	General	2011-02-19
138	Dr_138	DocLast	Cardiology	2021-11-28
139	Dr_139	DocLast	Pediatrics	2023-04-08
140	Dr_140	DocLast	Cardiology	2018-02-25
141	Dr_141	DocLast	Pediatrics	2011-12-21
142	Dr_142	DocLast	Orthopedics	2011-05-09
143	Dr_143	DocLast	Orthopedics	2024-07-19
144	Dr_144	DocLast	Orthopedics	2022-08-06
145	Dr_145	DocLast	General	2022-02-10
146	Dr_146	DocLast	Cardiology	2019-02-16
147	Dr_147	DocLast	Cardiology	2023-03-26
148	Dr_148	DocLast	Pediatrics	2011-07-01
149	Dr_149	DocLast	Cardiology	2012-04-18
150	Dr_150	DocLast	Orthopedics	2018-10-14
151	Dr_151	DocLast	Pediatrics	2022-07-05
152	Dr_152	DocLast	Orthopedics	2018-06-12
153	Dr_153	DocLast	Pediatrics	2017-09-22
154	Dr_154	DocLast	Orthopedics	2016-02-15
155	Dr_155	DocLast	General	2023-10-19
156	Dr_156	DocLast	Cardiology	2016-12-07
157	Dr_157	DocLast	General	2018-02-07
158	Dr_158	DocLast	Pediatrics	2012-03-05
159	Dr_159	DocLast	Orthopedics	2016-06-26
160	Dr_160	DocLast	Pediatrics	2016-02-02
161	Dr_161	DocLast	General	2011-12-12
162	Dr_162	DocLast	Orthopedics	2016-05-01
163	Dr_163	DocLast	Pediatrics	2015-01-19
164	Dr_164	DocLast	Pediatrics	2013-08-27
165	Dr_165	DocLast	Orthopedics	2024-02-06
166	Dr_166	DocLast	Pediatrics	2014-07-25
167	Dr_167	DocLast	General	2014-12-24
168	Dr_168	DocLast	General	2019-09-19
169	Dr_169	DocLast	Orthopedics	2021-01-03
170	Dr_170	DocLast	Orthopedics	2016-09-01
171	Dr_171	DocLast	Cardiology	2011-05-28
172	Dr_172	DocLast	Pediatrics	2011-04-18
173	Dr_173	DocLast	Orthopedics	2016-06-17
174	Dr_174	DocLast	General	2018-07-11
175	Dr_175	DocLast	Cardiology	2017-07-03
176	Dr_176	DocLast	General	2022-12-19
177	Dr_177	DocLast	Cardiology	2011-09-20
178	Dr_178	DocLast	Cardiology	2018-08-18
179	Dr_179	DocLast	Cardiology	2024-12-09
180	Dr_180	DocLast	Pediatrics	2023-08-21
181	Dr_181	DocLast	Cardiology	2019-09-03
182	Dr_182	DocLast	Orthopedics	2018-05-12
183	Dr_183	DocLast	Orthopedics	2013-07-08
184	Dr_184	DocLast	General	2020-05-08
185	Dr_185	DocLast	Pediatrics	2013-03-24
186	Dr_186	DocLast	Orthopedics	2015-12-08
187	Dr_187	DocLast	Pediatrics	2021-09-22
188	Dr_188	DocLast	Pediatrics	2010-05-15
189	Dr_189	DocLast	Pediatrics	2012-05-23
190	Dr_190	DocLast	General	2020-03-21
191	Dr_191	DocLast	Pediatrics	2020-06-18
192	Dr_192	DocLast	General	2024-06-23
193	Dr_193	DocLast	Orthopedics	2012-04-12
194	Dr_194	DocLast	General	2012-12-23
195	Dr_195	DocLast	Cardiology	2018-03-12
196	Dr_196	DocLast	General	2021-06-12
197	Dr_197	DocLast	Pediatrics	2016-03-26
198	Dr_198	DocLast	Cardiology	2018-06-06
199	Dr_199	DocLast	Pediatrics	2020-05-03
200	Dr_200	DocLast	Cardiology	2012-01-03
1002	2222 ╫ף"╫¿ ╫נ╫ס╫¿╫פ╫¥	Cardiology	\N	\N
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.patients (patient_id, first_name, last_name, birth_date, gender, phone, email, address) FROM stdin;
1	╫ש╫⌐╫¿╫נ╫£	╫ש╫⌐╫¿╫נ╫£╫ש	1985-05-20	Male	050-1234567	israel@email.com	Herzl 10, Tel Aviv
2	╫⌐╫¿╫פ	╫£╫ץ╫ש	1992-11-03	Female	052-7654321	sara.levi@email.com	Ben Gurion 5, Haifa
3	╫₧╫⌐╫פ	╫¢╫פ╫ƒ	1970-01-15	Male	054-1112223	moshe.c@email.com	Rabin 12, Jerusalem
4	Keslie	Happer	2025-11-19	Female	{phone}	{email}	{street_address}
5	Padgett	Livezey	2025-08-02	Male	{phone}	{email}	{street_address}
6	Gussie	Colby	2026-03-09	Polygender	{phone}	{email}	{street_address}
7	Jerry	Herity	2025-05-13	Male	{phone}	{email}	{street_address}
8	Jacynth	Riteley	2025-12-26	Female	{phone}	{email}	{street_address}
9	Angy	Gogin	2026-01-09	Female	{phone}	{email}	{street_address}
10	Kingsley	Sherwill	2025-12-09	Male	{phone}	{email}	{street_address}
11	Brigit	Pawsey	2025-11-08	Female	{phone}	{email}	{street_address}
12	Benoite	Steuart	2026-01-31	Female	{phone}	{email}	{street_address}
13	Scottie	Casaccio	2026-01-02	Male	{phone}	{email}	{street_address}
14	Angela	Gotter	2026-01-11	Female	{phone}	{email}	{street_address}
15	Niki	Maben	2025-09-03	Male	{phone}	{email}	{street_address}
16	Jenna	Dugdale	2026-03-22	Female	{phone}	{email}	{street_address}
17	Di	Tavener	2025-06-30	Female	{phone}	{email}	{street_address}
18	Calv	Powell	2025-05-30	Male	{phone}	{email}	{street_address}
19	Boycie	Muncie	2025-11-02	Male	{phone}	{email}	{street_address}
20	Hyatt	Blacker	2025-12-14	Male	{phone}	{email}	{street_address}
21	Hakeem	Larsen	2025-08-10	Male	{phone}	{email}	{street_address}
22	Mattheus	Brockley	2025-12-07	Male	{phone}	{email}	{street_address}
23	Pammie	Longland	2025-10-22	Female	{phone}	{email}	{street_address}
24	Brianna	covino	2025-09-26	Polygender	{phone}	{email}	{street_address}
25	Cob	Spellecy	2025-05-13	Male	{phone}	{email}	{street_address}
26	Prent	Clausen	2025-05-23	Male	{phone}	{email}	{street_address}
27	Lorain	Launchbury	2025-11-10	Female	{phone}	{email}	{street_address}
28	Kirsti	Crossthwaite	2026-02-28	Female	{phone}	{email}	{street_address}
29	Jackqueline	Tabourin	2025-07-07	Female	{phone}	{email}	{street_address}
30	Spike	Morgans	2026-02-18	Male	{phone}	{email}	{street_address}
31	Court	Reichhardt	2025-11-25	Male	{phone}	{email}	{street_address}
32	Rici	Georgins	2025-05-19	Female	{phone}	{email}	{street_address}
33	Robbert	Glidder	2025-06-20	Male	{phone}	{email}	{street_address}
34	Hedwig	Gorry	2025-11-01	Female	{phone}	{email}	{street_address}
35	Ariel	Fillery	2026-02-03	Female	{phone}	{email}	{street_address}
36	Ree	Benoy	2025-12-14	Female	{phone}	{email}	{street_address}
37	Farrah	Callinan	2026-04-14	Polygender	{phone}	{email}	{street_address}
38	Lorette	Restieaux	2025-10-09	Polygender	{phone}	{email}	{street_address}
39	Valli	Kleinstub	2025-11-23	Female	{phone}	{email}	{street_address}
40	Izaak	Gherardi	2025-10-15	Male	{phone}	{email}	{street_address}
41	Carroll	Tegler	2025-11-01	Male	{phone}	{email}	{street_address}
42	Berrie	Strotone	2025-10-22	Female	{phone}	{email}	{street_address}
43	Alfie	Frankes	2026-01-29	Male	{phone}	{email}	{street_address}
44	Shay	Gynne	2026-01-16	Female	{phone}	{email}	{street_address}
45	Dominik	Bonevant	2025-07-21	Male	{phone}	{email}	{street_address}
46	Dario	De Launde	2026-05-04	Male	{phone}	{email}	{street_address}
47	Sorcha	Keasey	2025-12-16	Female	{phone}	{email}	{street_address}
48	Barrie	Jeanet	2026-02-20	Male	{phone}	{email}	{street_address}
49	Benedicta	Bardell	2025-07-18	Female	{phone}	{email}	{street_address}
50	Yvette	Cocklin	2025-07-28	Female	{phone}	{email}	{street_address}
51	Aylmar	Iron	2025-07-21	Male	{phone}	{email}	{street_address}
52	Desi	Dawnay	2025-08-18	Agender	{phone}	{email}	{street_address}
53	Laetitia	Klassman	2025-10-03	Agender	{phone}	{email}	{street_address}
54	Arie	Order	2025-11-12	Genderfluid	{phone}	{email}	{street_address}
55	Lyndy	Doret	2025-05-29	Female	{phone}	{email}	{street_address}
56	Blair	Oret	2026-02-04	Male	{phone}	{email}	{street_address}
57	Dulcinea	Bartomeu	2025-05-13	Female	{phone}	{email}	{street_address}
58	Atlante	Comins	2026-01-12	Female	{phone}	{email}	{street_address}
59	Benson	Eagleton	2025-06-27	Male	{phone}	{email}	{street_address}
60	Gertrudis	Byrne	2026-05-02	Female	{phone}	{email}	{street_address}
61	Brig	Brognot	2025-10-25	Male	{phone}	{email}	{street_address}
62	Carmelia	Thomke	2026-04-07	Female	{phone}	{email}	{street_address}
63	George	Chillistone	2025-05-31	Female	{phone}	{email}	{street_address}
64	Wye	Ferreo	2025-05-16	Male	{phone}	{email}	{street_address}
65	Zorina	Sea	2025-09-03	Female	{phone}	{email}	{street_address}
66	Wilie	Astbury	2025-11-28	Polygender	{phone}	{email}	{street_address}
67	Matilde	Ivell	2025-09-19	Female	{phone}	{email}	{street_address}
68	Cassius	Ratazzi	2025-12-15	Male	{phone}	{email}	{street_address}
69	Daisie	Burhill	2025-08-09	Non-binary	{phone}	{email}	{street_address}
70	Chaunce	Lyven	2025-09-07	Male	{phone}	{email}	{street_address}
71	Damien	Berg	2025-10-17	Male	{phone}	{email}	{street_address}
72	Rancell	Teather	2025-08-12	Male	{phone}	{email}	{street_address}
73	Padget	Pasek	2025-10-18	Male	{phone}	{email}	{street_address}
74	Vassily	Phelips	2026-01-22	Male	{phone}	{email}	{street_address}
75	Coreen	Batram	2025-08-14	Non-binary	{phone}	{email}	{street_address}
76	Farah	Galler	2026-02-07	Female	{phone}	{email}	{street_address}
77	Gregorio	Wooller	2025-07-30	Polygender	{phone}	{email}	{street_address}
78	Eleanore	Robardey	2026-03-03	Genderfluid	{phone}	{email}	{street_address}
79	Barnie	Moakes	2025-06-11	Male	{phone}	{email}	{street_address}
80	Justin	Lawrey	2025-07-03	Male	{phone}	{email}	{street_address}
81	Kenneth	Powelee	2025-07-27	Male	{phone}	{email}	{street_address}
82	Berky	Rollin	2026-01-16	Male	{phone}	{email}	{street_address}
83	Diane	Daniaud	2025-12-18	Female	{phone}	{email}	{street_address}
84	Matthew	Eynaud	2026-01-18	Male	{phone}	{email}	{street_address}
85	Ag	Liddard	2025-06-17	Female	{phone}	{email}	{street_address}
86	Mufi	Dowdell	2026-05-05	Female	{phone}	{email}	{street_address}
87	Cece	Tolchard	2025-10-16	Male	{phone}	{email}	{street_address}
88	Emmerich	Worsley	2025-07-18	Male	{phone}	{email}	{street_address}
89	Alvina	Trematick	2026-04-11	Female	{phone}	{email}	{street_address}
90	Guillaume	Oldman	2025-07-01	Male	{phone}	{email}	{street_address}
91	Hank	Yashunin	2025-12-04	Male	{phone}	{email}	{street_address}
92	Wayland	Mc Dermid	2025-07-15	Male	{phone}	{email}	{street_address}
93	Pen	Benedit	2025-09-29	Male	{phone}	{email}	{street_address}
94	Clovis	Dredge	2025-10-28	Female	{phone}	{email}	{street_address}
95	Dominique	Shoreson	2026-01-29	Female	{phone}	{email}	{street_address}
96	Terrie	Jantel	2025-10-26	Female	{phone}	{email}	{street_address}
97	Tamma	Hughland	2025-10-03	Female	{phone}	{email}	{street_address}
98	Gardner	Burwood	2025-08-10	Male	{phone}	{email}	{street_address}
99	Cody	Galvan	2026-02-07	Male	{phone}	{email}	{street_address}
100	Shirline	Maddin	2026-03-17	Female	{phone}	{email}	{street_address}
101	Wye	Crowthe	2025-09-22	Male	{phone}	{email}	{street_address}
102	Leroi	Hannant	2025-07-26	Male	{phone}	{email}	{street_address}
103	Jenn	Pougher	2026-01-29	Female	{phone}	{email}	{street_address}
104	Adelaide	Keenlyside	2025-11-29	Genderqueer	{phone}	{email}	{street_address}
105	Reube	Gallardo	2026-03-10	Male	{phone}	{email}	{street_address}
106	Nannie	Habershon	2026-04-24	Female	{phone}	{email}	{street_address}
107	Wilt	Poytress	2026-02-08	Male	{phone}	{email}	{street_address}
108	Alejandra	Conkling	2025-09-14	Bigender	{phone}	{email}	{street_address}
109	Lincoln	Arsnell	2025-10-14	Male	{phone}	{email}	{street_address}
110	Ruben	Eberle	2026-03-26	Male	{phone}	{email}	{street_address}
111	Corby	Hackin	2025-05-28	Male	{phone}	{email}	{street_address}
112	Elvina	Revill	2025-08-06	Female	{phone}	{email}	{street_address}
113	Rabbi	Barwood	2026-03-15	Male	{phone}	{email}	{street_address}
114	Colver	Blackster	2026-03-01	Male	{phone}	{email}	{street_address}
115	Stearne	Eronie	2025-12-02	Male	{phone}	{email}	{street_address}
116	Devin	Petren	2026-03-22	Genderqueer	{phone}	{email}	{street_address}
117	Audre	Dellenty	2025-12-29	Non-binary	{phone}	{email}	{street_address}
118	Zeb	Ventham	2025-10-04	Male	{phone}	{email}	{street_address}
119	Mikaela	Plampin	2026-02-13	Polygender	{phone}	{email}	{street_address}
120	Homerus	Haseman	2025-07-17	Male	{phone}	{email}	{street_address}
121	Odey	Fawssett	2025-09-01	Male	{phone}	{email}	{street_address}
122	Izabel	Barling	2026-03-15	Genderfluid	{phone}	{email}	{street_address}
123	Arron	Howselee	2026-03-07	Male	{phone}	{email}	{street_address}
124	Caressa	Rastrick	2026-04-02	Genderfluid	{phone}	{email}	{street_address}
125	Javier	Du Hamel	2025-11-22	Male	{phone}	{email}	{street_address}
126	Bethena	Benterman	2025-12-01	Female	{phone}	{email}	{street_address}
127	Ashlee	Labbett	2026-05-08	Female	{phone}	{email}	{street_address}
128	Renault	Cussons	2025-06-04	Male	{phone}	{email}	{street_address}
129	Berta	Scroggs	2025-06-28	Female	{phone}	{email}	{street_address}
130	Janean	Meanwell	2025-12-22	Female	{phone}	{email}	{street_address}
131	Dinnie	Roggers	2025-08-11	Female	{phone}	{email}	{street_address}
132	Lock	West	2025-10-22	Male	{phone}	{email}	{street_address}
133	Jeanine	Moxham	2026-02-15	Polygender	{phone}	{email}	{street_address}
134	Janifer	Nerval	2025-08-24	Female	{phone}	{email}	{street_address}
135	Wynn	Alu	2025-10-27	Female	{phone}	{email}	{street_address}
136	Kellen	Bennough	2025-06-12	Polygender	{phone}	{email}	{street_address}
137	Truman	Arlett	2025-12-24	Male	{phone}	{email}	{street_address}
138	Brad	Whitney	2025-09-03	Male	{phone}	{email}	{street_address}
139	Mattias	Anderer	2026-01-06	Male	{phone}	{email}	{street_address}
140	Bobbye	Conan	2025-07-14	Female	{phone}	{email}	{street_address}
141	Brinn	Roose	2025-06-21	Female	{phone}	{email}	{street_address}
142	Willard	Kealy	2026-04-21	Male	{phone}	{email}	{street_address}
143	Delmer	Colhoun	2025-11-23	Male	{phone}	{email}	{street_address}
144	Eberto	Cahalan	2025-11-03	Male	{phone}	{email}	{street_address}
145	Theodoric	Ludgate	2025-08-26	Male	{phone}	{email}	{street_address}
146	Niles	Kiddy	2025-12-03	Male	{phone}	{email}	{street_address}
147	Abrahan	Bello	2026-04-17	Male	{phone}	{email}	{street_address}
148	Tom	Orgen	2025-08-16	Male	{phone}	{email}	{street_address}
149	Brit	Verdon	2026-03-29	Male	{phone}	{email}	{street_address}
150	Jay	Danielovitch	2025-10-23	Male	{phone}	{email}	{street_address}
151	Kane	Letty	2026-01-21	Male	{phone}	{email}	{street_address}
152	Derwin	Bolton	2025-10-08	Male	{phone}	{email}	{street_address}
153	Maurene	Read	2026-01-08	Female	{phone}	{email}	{street_address}
154	Sileas	Jeanet	2025-05-29	Female	{phone}	{email}	{street_address}
155	Teador	Curd	2025-07-01	Male	{phone}	{email}	{street_address}
156	Cecile	Iwaszkiewicz	2025-08-07	Bigender	{phone}	{email}	{street_address}
157	Wiatt	Deery	2026-04-07	Male	{phone}	{email}	{street_address}
158	Ynes	De Roeck	2025-06-10	Female	{phone}	{email}	{street_address}
159	Darin	Roberto	2025-07-12	Male	{phone}	{email}	{street_address}
160	Rhona	Lamasna	2025-12-25	Female	{phone}	{email}	{street_address}
161	Rafaellle	Kleinplac	2025-09-20	Male	{phone}	{email}	{street_address}
162	Sara-ann	Wanne	2025-05-21	Female	{phone}	{email}	{street_address}
163	Coop	Hendrich	2025-06-11	Male	{phone}	{email}	{street_address}
164	Brandtr	Lattin	2025-07-24	Male	{phone}	{email}	{street_address}
165	Jacintha	De Mars	2026-05-03	Female	{phone}	{email}	{street_address}
166	Kermy	Bouchier	2025-08-25	Male	{phone}	{email}	{street_address}
167	Winny	Milier	2026-04-22	Male	{phone}	{email}	{street_address}
168	Issi	Corr	2026-01-30	Female	{phone}	{email}	{street_address}
169	Mayer	Pittet	2025-11-04	Male	{phone}	{email}	{street_address}
170	Florina	Palphramand	2025-07-19	Female	{phone}	{email}	{street_address}
171	Luella	Rosetti	2026-02-05	Female	{phone}	{email}	{street_address}
172	Brew	Perren	2025-09-21	Male	{phone}	{email}	{street_address}
173	Bev	Bausmann	2025-05-16	Male	{phone}	{email}	{street_address}
174	Meredith	Andrey	2025-11-18	Male	{phone}	{email}	{street_address}
175	Peyter	Roscoe	2026-01-15	Male	{phone}	{email}	{street_address}
176	Seumas	Makey	2026-02-16	Male	{phone}	{email}	{street_address}
177	Catherina	Lightewood	2025-05-26	Non-binary	{phone}	{email}	{street_address}
178	Obed	Gooden	2025-11-01	Male	{phone}	{email}	{street_address}
179	Bernadette	Buggy	2025-09-18	Female	{phone}	{email}	{street_address}
180	Leigh	Ellershaw	2025-12-28	Female	{phone}	{email}	{street_address}
181	Marne	Issit	2026-03-08	Female	{phone}	{email}	{street_address}
182	Waverley	MacRierie	2026-01-29	Male	{phone}	{email}	{street_address}
183	Adolphus	Grebner	2025-12-21	Male	{phone}	{email}	{street_address}
184	Harris	Tallon	2025-10-10	Male	{phone}	{email}	{street_address}
185	Amery	Brightman	2026-04-07	Bigender	{phone}	{email}	{street_address}
186	Barbara-anne	Farncombe	2026-04-23	Female	{phone}	{email}	{street_address}
187	Robyn	Jahnel	2025-10-21	Female	{phone}	{email}	{street_address}
188	Garrard	Cogar	2025-12-30	Male	{phone}	{email}	{street_address}
189	Agosto	Berthelmot	2025-11-23	Male	{phone}	{email}	{street_address}
190	Verena	Vondrak	2026-01-04	Female	{phone}	{email}	{street_address}
191	Hendrik	Packwood	2025-10-04	Agender	{phone}	{email}	{street_address}
192	Maggi	Cosgriff	2026-04-02	Female	{phone}	{email}	{street_address}
193	Conant	Scalera	2025-07-26	Male	{phone}	{email}	{street_address}
194	Elisha	Saunter	2025-07-31	Male	{phone}	{email}	{street_address}
195	Giuseppe	McCullouch	2026-02-08	Male	{phone}	{email}	{street_address}
196	Kalli	Bartalini	2026-03-13	Female	{phone}	{email}	{street_address}
197	Lorita	Alston	2025-12-21	Female	{phone}	{email}	{street_address}
198	Elnore	Jakobssen	2025-07-06	Female	{phone}	{email}	{street_address}
199	Micah	Daniau	2026-01-22	Male	{phone}	{email}	{street_address}
200	Tann	Pocklington	2025-11-14	Male	{phone}	{email}	{street_address}
201	William	Wilcher	2025-10-24	Male	{phone}	{email}	{street_address}
202	Avie	O'Siaghail	2025-11-18	Female	{phone}	{email}	{street_address}
203	Bettina	Sidney	2025-11-02	Female	{phone}	{email}	{street_address}
204	Lenci	Shackelton	2025-12-08	Male	{phone}	{email}	{street_address}
205	Alard	Bundey	2025-08-22	Male	{phone}	{email}	{street_address}
206	Burty	Klausen	2026-03-30	Genderqueer	{phone}	{email}	{street_address}
207	Huberto	Crutcher	2025-09-23	Male	{phone}	{email}	{street_address}
208	Essy	Duckham	2026-02-06	Female	{phone}	{email}	{street_address}
209	Milka	Huikerby	2026-01-24	Female	{phone}	{email}	{street_address}
210	Tiler	Gullifant	2025-10-25	Male	{phone}	{email}	{street_address}
211	Reese	Zucker	2026-01-12	Male	{phone}	{email}	{street_address}
212	Elfrieda	Ocklin	2026-03-28	Female	{phone}	{email}	{street_address}
213	Josee	Oldmeadow	2025-08-21	Female	{phone}	{email}	{street_address}
214	Nathanael	Prattington	2026-04-02	Male	{phone}	{email}	{street_address}
215	Shelba	Podmore	2026-05-10	Female	{phone}	{email}	{street_address}
216	Mallory	Sommer	2026-04-30	Female	{phone}	{email}	{street_address}
217	Axe	Gilleon	2025-07-27	Male	{phone}	{email}	{street_address}
218	Maure	Hollibone	2025-06-02	Female	{phone}	{email}	{street_address}
219	Nico	McLauchlin	2025-12-09	Male	{phone}	{email}	{street_address}
220	Early	Jasper	2025-12-12	Male	{phone}	{email}	{street_address}
221	Emmery	Stallworth	2026-04-27	Male	{phone}	{email}	{street_address}
222	Jarrid	Scoyles	2025-10-13	Male	{phone}	{email}	{street_address}
223	Lucita	Ayton	2025-12-11	Female	{phone}	{email}	{street_address}
224	Arlena	Kildea	2025-07-26	Female	{phone}	{email}	{street_address}
225	Tobe	Breazeall	2025-09-22	Male	{phone}	{email}	{street_address}
226	Donal	Tournay	2026-04-09	Polygender	{phone}	{email}	{street_address}
227	Drucie	Treadaway	2025-09-16	Female	{phone}	{email}	{street_address}
228	Moss	Pearn	2025-06-29	Male	{phone}	{email}	{street_address}
229	Bradley	Conford	2025-06-03	Male	{phone}	{email}	{street_address}
230	Tiena	Tembey	2025-09-21	Female	{phone}	{email}	{street_address}
231	Louisette	Headford	2025-12-24	Genderfluid	{phone}	{email}	{street_address}
232	Byron	Gravett	2026-05-08	Male	{phone}	{email}	{street_address}
233	Pasquale	Bradnam	2025-08-10	Genderqueer	{phone}	{email}	{street_address}
234	Chick	Kieran	2026-03-03	Male	{phone}	{email}	{street_address}
235	Ainslee	Webberley	2025-08-30	Female	{phone}	{email}	{street_address}
236	Alicia	Waldock	2025-08-13	Female	{phone}	{email}	{street_address}
237	Godard	Humbles	2025-06-14	Male	{phone}	{email}	{street_address}
238	Loren	Malarkey	2026-01-15	Male	{phone}	{email}	{street_address}
239	Arnoldo	Jarrard	2025-11-10	Male	{phone}	{email}	{street_address}
240	Ulick	Merrigan	2025-07-21	Male	{phone}	{email}	{street_address}
241	Aland	Chaplain	2026-03-02	Male	{phone}	{email}	{street_address}
242	Stacee	Tock	2026-03-21	Male	{phone}	{email}	{street_address}
243	Swen	Headey	2025-06-26	Male	{phone}	{email}	{street_address}
244	Dario	Delhay	2025-06-30	Male	{phone}	{email}	{street_address}
245	Grete	Dziwisz	2025-05-21	Female	{phone}	{email}	{street_address}
246	Tabor	Kemme	2026-01-07	Male	{phone}	{email}	{street_address}
247	Gladys	Smittoune	2025-11-29	Female	{phone}	{email}	{street_address}
248	Alissa	Brassill	2026-04-13	Female	{phone}	{email}	{street_address}
249	Elmo	Kimberley	2025-11-18	Male	{phone}	{email}	{street_address}
250	Corney	Fildes	2025-12-28	Male	{phone}	{email}	{street_address}
251	Bobbye	Orchart	2025-08-14	Female	{phone}	{email}	{street_address}
252	April	Hayth	2025-08-20	Female	{phone}	{email}	{street_address}
253	Kimbell	Sciacovelli	2025-10-08	Male	{phone}	{email}	{street_address}
254	Dionis	De Vries	2025-08-19	Female	{phone}	{email}	{street_address}
255	Jdavie	McRoberts	2026-04-18	Male	{phone}	{email}	{street_address}
256	Caresa	Briscoe	2026-01-09	Female	{phone}	{email}	{street_address}
257	Viv	Orgel	2026-04-20	Female	{phone}	{email}	{street_address}
258	Donnamarie	Woolward	2025-10-05	Female	{phone}	{email}	{street_address}
259	Orland	Filipyev	2025-07-15	Male	{phone}	{email}	{street_address}
260	Conant	Stainer	2026-04-23	Male	{phone}	{email}	{street_address}
261	Cloe	Gludor	2025-11-01	Female	{phone}	{email}	{street_address}
262	Emmy	Deware	2025-06-12	Genderfluid	{phone}	{email}	{street_address}
263	Sim	Flucks	2026-04-13	Male	{phone}	{email}	{street_address}
264	Gray	Matusiak	2025-08-17	Male	{phone}	{email}	{street_address}
265	Abbie	Noli	2026-01-27	Female	{phone}	{email}	{street_address}
266	Berkly	Mordue	2026-01-22	Male	{phone}	{email}	{street_address}
267	Pia	Busch	2025-12-31	Female	{phone}	{email}	{street_address}
268	Fredericka	Haley	2025-09-27	Female	{phone}	{email}	{street_address}
269	Dean	Tipton	2025-10-21	Male	{phone}	{email}	{street_address}
270	Paulie	Ashment	2025-11-01	Female	{phone}	{email}	{street_address}
271	Grannie	Liggins	2026-04-06	Male	{phone}	{email}	{street_address}
272	Hubert	Duckerin	2025-06-08	Male	{phone}	{email}	{street_address}
273	Deerdre	Lerner	2025-06-29	Bigender	{phone}	{email}	{street_address}
274	Noelle	Norbury	2025-12-15	Female	{phone}	{email}	{street_address}
275	Staffard	Beat	2026-03-27	Male	{phone}	{email}	{street_address}
276	Kareem	Brymner	2026-04-23	Male	{phone}	{email}	{street_address}
277	Humberto	Karpol	2025-08-16	Male	{phone}	{email}	{street_address}
278	Trixy	Liffey	2026-02-14	Female	{phone}	{email}	{street_address}
279	Stanley	Sivyer	2026-04-09	Male	{phone}	{email}	{street_address}
280	Mommy	Chominski	2025-08-30	Genderfluid	{phone}	{email}	{street_address}
281	Mitchael	Burghall	2026-01-28	Male	{phone}	{email}	{street_address}
282	Jaine	Ingyon	2025-10-04	Agender	{phone}	{email}	{street_address}
283	Riccardo	Derisley	2026-03-18	Male	{phone}	{email}	{street_address}
284	Alic	Pepperill	2025-10-05	Male	{phone}	{email}	{street_address}
285	Townie	Gauford	2026-01-03	Male	{phone}	{email}	{street_address}
286	Shanda	Duiged	2025-06-03	Genderqueer	{phone}	{email}	{street_address}
287	Deny	Keighly	2025-11-06	Female	{phone}	{email}	{street_address}
288	Lira	Malcolm	2025-06-26	Female	{phone}	{email}	{street_address}
289	Griffie	Petersen	2025-09-21	Male	{phone}	{email}	{street_address}
290	Donal	Feares	2026-02-17	Male	{phone}	{email}	{street_address}
291	Charlean	Tumasian	2026-05-11	Female	{phone}	{email}	{street_address}
292	Betsey	Ingliby	2025-05-22	Female	{phone}	{email}	{street_address}
293	Gretel	Yaakov	2026-05-04	Female	{phone}	{email}	{street_address}
294	Yolanthe	Monketon	2025-09-16	Female	{phone}	{email}	{street_address}
295	Clemmie	Scotchbourouge	2025-12-19	Male	{phone}	{email}	{street_address}
296	Kania	Joliffe	2026-02-13	Female	{phone}	{email}	{street_address}
297	Martina	Melmoth	2026-04-03	Female	{phone}	{email}	{street_address}
298	Jeanie	Studdal	2026-04-01	Female	{phone}	{email}	{street_address}
299	Bamby	McIlwraith	2025-11-21	Female	{phone}	{email}	{street_address}
300	Lazaro	Gino	2026-03-26	Male	{phone}	{email}	{street_address}
301	Baxter	Polendine	2026-02-10	Male	{phone}	{email}	{street_address}
302	Molli	Ranken	2025-11-10	Female	{phone}	{email}	{street_address}
303	Ole	O' Mulderrig	2025-10-08	Male	{phone}	{email}	{street_address}
304	Zackariah	Merkle	2025-10-08	Male	{phone}	{email}	{street_address}
305	Ezmeralda	Everiss	2025-12-03	Female	{phone}	{email}	{street_address}
306	Raynor	Alloway	2025-06-02	Male	{phone}	{email}	{street_address}
307	Analise	Pringle	2025-06-05	Female	{phone}	{email}	{street_address}
308	Goldarina	Bettanay	2026-04-02	Female	{phone}	{email}	{street_address}
309	Robinson	Petken	2025-11-04	Male	{phone}	{email}	{street_address}
310	Adham	Rodman	2025-10-29	Male	{phone}	{email}	{street_address}
311	Lemmie	Shattock	2025-08-14	Male	{phone}	{email}	{street_address}
312	Olympe	Armall	2025-08-21	Female	{phone}	{email}	{street_address}
313	Adelheid	Wilflinger	2025-06-11	Female	{phone}	{email}	{street_address}
314	Susan	Benzie	2026-02-25	Female	{phone}	{email}	{street_address}
315	Rusty	Rance	2026-02-16	Male	{phone}	{email}	{street_address}
316	Damaris	Netting	2025-07-29	Female	{phone}	{email}	{street_address}
317	Callida	Shickle	2026-02-11	Female	{phone}	{email}	{street_address}
318	Rakel	Zapater	2026-03-12	Female	{phone}	{email}	{street_address}
319	Ad	Grayson	2026-04-01	Male	{phone}	{email}	{street_address}
320	Krista	Casajuana	2026-03-20	Female	{phone}	{email}	{street_address}
321	Madeline	Phoebe	2025-08-02	Female	{phone}	{email}	{street_address}
322	Marlowe	Chater	2026-01-18	Male	{phone}	{email}	{street_address}
323	Kelbee	Ciric	2025-10-08	Male	{phone}	{email}	{street_address}
324	Warden	Beaudry	2026-01-20	Male	{phone}	{email}	{street_address}
325	Wynne	Richold	2025-11-29	Female	{phone}	{email}	{street_address}
326	Estel	Serjent	2025-07-27	Female	{phone}	{email}	{street_address}
327	Kipper	Segar	2026-04-04	Male	{phone}	{email}	{street_address}
328	Gerri	Bosomworth	2025-12-12	Female	{phone}	{email}	{street_address}
329	Lynna	Ide	2026-04-18	Female	{phone}	{email}	{street_address}
330	Jobey	Pettifer	2025-11-12	Female	{phone}	{email}	{street_address}
331	Indira	Beavers	2025-06-07	Genderqueer	{phone}	{email}	{street_address}
332	Gianna	Faircley	2025-08-23	Female	{phone}	{email}	{street_address}
333	Matthaeus	Cadwallader	2025-07-18	Male	{phone}	{email}	{street_address}
334	Marianna	Roncelli	2025-11-10	Female	{phone}	{email}	{street_address}
335	Egan	Burkart	2026-02-17	Male	{phone}	{email}	{street_address}
336	Buddy	De Cruz	2025-11-13	Male	{phone}	{email}	{street_address}
337	Wally	Boggers	2026-03-03	Female	{phone}	{email}	{street_address}
338	Babara	Phillpotts	2025-05-18	Female	{phone}	{email}	{street_address}
339	Tanya	Hudleston	2026-04-15	Female	{phone}	{email}	{street_address}
340	Sofie	Rhymes	2025-07-30	Female	{phone}	{email}	{street_address}
341	Heddi	Nuss	2026-04-24	Female	{phone}	{email}	{street_address}
342	Wallace	Lapworth	2025-06-16	Male	{phone}	{email}	{street_address}
343	Matilda	Swanton	2025-07-11	Female	{phone}	{email}	{street_address}
344	Staci	Blann	2025-07-28	Bigender	{phone}	{email}	{street_address}
345	Benjy	Manicom	2025-10-07	Male	{phone}	{email}	{street_address}
346	Sterling	Knotton	2026-03-17	Male	{phone}	{email}	{street_address}
347	Melesa	Eagar	2026-01-24	Female	{phone}	{email}	{street_address}
348	Karine	Mucillo	2025-07-09	Female	{phone}	{email}	{street_address}
349	Alverta	Sarath	2026-01-31	Female	{phone}	{email}	{street_address}
350	Quent	McGrey	2025-08-27	Male	{phone}	{email}	{street_address}
351	Sawyer	Adenet	2025-06-29	Male	{phone}	{email}	{street_address}
352	Hayes	Feavyour	2025-12-03	Non-binary	{phone}	{email}	{street_address}
353	Lynnette	Kendrew	2026-04-30	Female	{phone}	{email}	{street_address}
354	Emmanuel	Joist	2025-07-11	Male	{phone}	{email}	{street_address}
355	Thedric	Corhard	2025-09-08	Male	{phone}	{email}	{street_address}
356	Penny	Smalley	2025-06-26	Female	{phone}	{email}	{street_address}
357	Fiona	Meric	2026-04-13	Female	{phone}	{email}	{street_address}
358	Eduino	Yetman	2026-01-09	Male	{phone}	{email}	{street_address}
359	Johnathon	Jain	2026-04-12	Male	{phone}	{email}	{street_address}
360	Renault	Gerwood	2026-04-30	Male	{phone}	{email}	{street_address}
361	Vassili	Gadeaux	2026-01-22	Male	{phone}	{email}	{street_address}
362	Berri	Ferreo	2025-10-09	Female	{phone}	{email}	{street_address}
363	Artie	Howerd	2026-03-30	Male	{phone}	{email}	{street_address}
364	Leslie	Sollis	2026-02-01	Male	{phone}	{email}	{street_address}
365	Samuel	Cleaver	2025-11-10	Male	{phone}	{email}	{street_address}
366	Tyson	Waddoups	2025-07-10	Male	{phone}	{email}	{street_address}
367	Dennet	Reddington	2025-08-21	Male	{phone}	{email}	{street_address}
368	Camey	Cady	2025-11-26	Male	{phone}	{email}	{street_address}
369	Stu	Jaquin	2025-11-29	Male	{phone}	{email}	{street_address}
370	Aurlie	Dealtry	2025-05-24	Female	{phone}	{email}	{street_address}
371	Christye	Amsden	2026-05-06	Female	{phone}	{email}	{street_address}
372	Christoph	Alans	2025-05-26	Male	{phone}	{email}	{street_address}
373	Gustie	O'Caine	2026-01-31	Female	{phone}	{email}	{street_address}
374	Fraze	Spores	2025-11-28	Male	{phone}	{email}	{street_address}
375	Westleigh	Strank	2025-09-20	Bigender	{phone}	{email}	{street_address}
376	Doug	Tailby	2025-10-02	Male	{phone}	{email}	{street_address}
377	Yul	Asey	2026-03-06	Male	{phone}	{email}	{street_address}
378	Ezekiel	Ivachyov	2025-07-30	Male	{phone}	{email}	{street_address}
379	Kalle	Pullman	2025-08-22	Male	{phone}	{email}	{street_address}
380	Anderson	Broadbridge	2025-10-29	Male	{phone}	{email}	{street_address}
381	Gleda	Ellor	2025-09-14	Female	{phone}	{email}	{street_address}
382	Guss	Treadgear	2025-07-21	Male	{phone}	{email}	{street_address}
383	Dominga	Skilbeck	2026-01-02	Female	{phone}	{email}	{street_address}
384	Lynnet	Piddington	2025-10-03	Female	{phone}	{email}	{street_address}
385	Verene	Klaes	2026-01-05	Female	{phone}	{email}	{street_address}
386	Robina	Hurst	2026-01-08	Female	{phone}	{email}	{street_address}
387	Isador	Leebetter	2025-08-08	Male	{phone}	{email}	{street_address}
388	Sutherland	Zamorrano	2025-10-08	Male	{phone}	{email}	{street_address}
389	Gavra	Worvill	2025-06-22	Female	{phone}	{email}	{street_address}
390	Farleigh	Rootham	2025-07-22	Male	{phone}	{email}	{street_address}
391	Kane	Colliford	2025-10-27	Genderqueer	{phone}	{email}	{street_address}
392	Sallyanne	Edmondson	2025-08-27	Female	{phone}	{email}	{street_address}
393	Dionisio	Marzelle	2026-04-16	Male	{phone}	{email}	{street_address}
394	Freddi	Harrigan	2025-10-17	Female	{phone}	{email}	{street_address}
395	Charmion	Giacomucci	2025-12-11	Female	{phone}	{email}	{street_address}
396	Fergus	Shillito	2025-05-21	Male	{phone}	{email}	{street_address}
397	Ginger	Reggler	2026-04-29	Male	{phone}	{email}	{street_address}
398	Gerrie	Manuello	2025-07-06	Male	{phone}	{email}	{street_address}
399	Dona	Gorges	2025-12-14	Female	{phone}	{email}	{street_address}
400	Gavra	Lippiett	2025-08-19	Female	{phone}	{email}	{street_address}
401	Zahara	Wyllie	2025-07-12	Female	{phone}	{email}	{street_address}
402	Annetta	Westmerland	2025-05-21	Female	{phone}	{email}	{street_address}
403	Ebonee	Batman	2025-08-11	Bigender	{phone}	{email}	{street_address}
404	Penni	Lamburn	2026-01-15	Female	{phone}	{email}	{street_address}
405	Herb	Jakubiak	2026-01-08	Male	{phone}	{email}	{street_address}
406	Nedi	McAw	2025-11-15	Genderqueer	{phone}	{email}	{street_address}
407	Judas	Kineton	2025-06-18	Male	{phone}	{email}	{street_address}
408	Bendicty	Myton	2026-03-07	Male	{phone}	{email}	{street_address}
409	Justinian	Traite	2025-09-06	Male	{phone}	{email}	{street_address}
410	Pauly	Kiwitz	2025-05-22	Female	{phone}	{email}	{street_address}
411	Aurea	Rochester	2025-07-29	Female	{phone}	{email}	{street_address}
412	Bay	Barlass	2026-04-05	Male	{phone}	{email}	{street_address}
413	Thorstein	Antonoyev	2025-07-18	Male	{phone}	{email}	{street_address}
414	Reinaldo	Hulls	2025-07-14	Male	{phone}	{email}	{street_address}
415	Jessie	Klageman	2025-07-13	Male	{phone}	{email}	{street_address}
416	Devora	Alexandrescu	2025-11-20	Female	{phone}	{email}	{street_address}
417	Sloane	Boldecke	2025-05-25	Male	{phone}	{email}	{street_address}
418	Alvera	Copeman	2026-03-09	Female	{phone}	{email}	{street_address}
419	Lainey	Fairham	2025-07-06	Female	{phone}	{email}	{street_address}
420	Alden	Blaby	2025-06-22	Male	{phone}	{email}	{street_address}
421	Gisela	Janku	2026-01-12	Female	{phone}	{email}	{street_address}
422	Laural	Awcoate	2025-08-31	Female	{phone}	{email}	{street_address}
423	Nigel	Trainer	2025-07-04	Genderfluid	{phone}	{email}	{street_address}
424	Pincus	Hubberstey	2025-08-05	Male	{phone}	{email}	{street_address}
425	Dasi	De Ortega	2025-07-30	Female	{phone}	{email}	{street_address}
426	Gordy	Montacute	2026-01-28	Male	{phone}	{email}	{street_address}
427	Evonne	Tomasino	2026-02-13	Female	{phone}	{email}	{street_address}
428	Glyn	Bernt	2025-09-08	Female	{phone}	{email}	{street_address}
429	Enoch	Revel	2026-05-11	Male	{phone}	{email}	{street_address}
430	Thornie	Gouldstone	2025-08-17	Male	{phone}	{email}	{street_address}
431	Rozelle	Duckers	2025-06-27	Female	{phone}	{email}	{street_address}
432	Felipe	Raubenheimer	2026-05-09	Male	{phone}	{email}	{street_address}
433	Marty	Paolicchi	2025-08-18	Male	{phone}	{email}	{street_address}
434	Cazzie	Woolens	2025-09-01	Male	{phone}	{email}	{street_address}
435	Sayer	Cambell	2026-05-07	Male	{phone}	{email}	{street_address}
436	Hermie	Crop	2026-04-13	Male	{phone}	{email}	{street_address}
437	Brietta	Darnborough	2026-04-04	Female	{phone}	{email}	{street_address}
438	Shayne	Statton	2026-04-23	Female	{phone}	{email}	{street_address}
439	Rona	Bianco	2026-02-25	Female	{phone}	{email}	{street_address}
440	Rivalee	Barensky	2025-07-19	Female	{phone}	{email}	{street_address}
441	Kirby	Joppich	2025-12-26	Female	{phone}	{email}	{street_address}
442	Annelise	Nuemann	2025-12-19	Bigender	{phone}	{email}	{street_address}
443	Jaquenette	Denisyuk	2025-07-02	Female	{phone}	{email}	{street_address}
444	Maurits	Battill	2025-10-12	Male	{phone}	{email}	{street_address}
445	Bertine	Rix	2025-11-20	Female	{phone}	{email}	{street_address}
446	Rodie	Martins	2025-12-02	Female	{phone}	{email}	{street_address}
447	Kleon	Derham	2026-03-02	Male	{phone}	{email}	{street_address}
448	Vernen	Shovel	2025-09-22	Male	{phone}	{email}	{street_address}
449	Hamel	Mainz	2025-07-06	Male	{phone}	{email}	{street_address}
450	Binni	Commin	2025-10-02	Female	{phone}	{email}	{street_address}
451	Gibbie	Blincow	2026-04-25	Male	{phone}	{email}	{street_address}
452	Guido	Garbert	2025-11-18	Male	{phone}	{email}	{street_address}
453	Cindy	Prester	2026-05-10	Female	{phone}	{email}	{street_address}
454	Rice	Walrond	2026-01-27	Male	{phone}	{email}	{street_address}
455	Dermot	Michieli	2026-01-29	Male	{phone}	{email}	{street_address}
456	Devora	Razoux	2025-06-25	Female	{phone}	{email}	{street_address}
457	Conni	MacAllan	2025-05-15	Female	{phone}	{email}	{street_address}
458	Glyn	Cowey	2025-10-06	Male	{phone}	{email}	{street_address}
459	Aguste	Padberry	2025-09-01	Male	{phone}	{email}	{street_address}
460	Galvin	Aucutt	2025-10-30	Male	{phone}	{email}	{street_address}
461	Lebbie	Byatt	2026-01-20	Female	{phone}	{email}	{street_address}
462	Hill	Verney	2025-08-30	Male	{phone}	{email}	{street_address}
463	Chase	Messingham	2025-11-14	Male	{phone}	{email}	{street_address}
464	Amargo	Shipp	2025-10-24	Female	{phone}	{email}	{street_address}
465	Terese	McLice	2025-06-20	Female	{phone}	{email}	{street_address}
466	Manolo	Naish	2025-05-17	Male	{phone}	{email}	{street_address}
467	Adriane	Domesday	2025-12-23	Female	{phone}	{email}	{street_address}
468	Alphonse	Maletratt	2025-10-06	Male	{phone}	{email}	{street_address}
469	Gene	Avrasin	2026-02-25	Male	{phone}	{email}	{street_address}
470	Ripley	Ianinotti	2026-03-01	Male	{phone}	{email}	{street_address}
471	Ailina	Sprade	2025-08-22	Female	{phone}	{email}	{street_address}
472	Skell	Perkinson	2025-10-14	Male	{phone}	{email}	{street_address}
473	Zackariah	Mankor	2026-03-18	Male	{phone}	{email}	{street_address}
474	Germain	Bonsul	2025-06-01	Male	{phone}	{email}	{street_address}
475	Jenna	Margetson	2025-12-04	Female	{phone}	{email}	{street_address}
476	Carlie	Ring	2026-02-20	Female	{phone}	{email}	{street_address}
477	Remus	Nickoll	2025-07-12	Male	{phone}	{email}	{street_address}
478	Esra	Clineck	2026-01-15	Male	{phone}	{email}	{street_address}
479	Anselm	Van der Kruis	2026-01-25	Male	{phone}	{email}	{street_address}
480	Carrol	Chestle	2026-02-16	Agender	{phone}	{email}	{street_address}
481	Freddie	Dibble	2026-02-11	Female	{phone}	{email}	{street_address}
482	Estele	Vurley	2025-05-23	Female	{phone}	{email}	{street_address}
483	Hinda	Sigmund	2026-03-05	Female	{phone}	{email}	{street_address}
484	Joyce	Tirkin	2025-10-28	Female	{phone}	{email}	{street_address}
485	Ervin	Hurtic	2025-06-30	Male	{phone}	{email}	{street_address}
486	Marcellina	Trousdale	2025-11-28	Genderqueer	{phone}	{email}	{street_address}
487	Tate	Ramplee	2025-11-16	Male	{phone}	{email}	{street_address}
488	Ranee	Sheffield	2026-03-21	Female	{phone}	{email}	{street_address}
489	Geoffry	Graser	2026-02-22	Male	{phone}	{email}	{street_address}
490	Ripley	Kinchlea	2025-08-05	Male	{phone}	{email}	{street_address}
491	Piper	Doohey	2025-07-06	Female	{phone}	{email}	{street_address}
492	Nertie	Portman	2026-02-18	Female	{phone}	{email}	{street_address}
493	Austen	Cawsey	2026-01-30	Male	{phone}	{email}	{street_address}
494	Davin	Yurov	2025-07-02	Male	{phone}	{email}	{street_address}
495	Patric	Gerhold	2026-02-21	Male	{phone}	{email}	{street_address}
496	Kin	Hargie	2026-03-02	Male	{phone}	{email}	{street_address}
497	Foster	Aymes	2026-04-13	Male	{phone}	{email}	{street_address}
498	Winslow	Wyche	2025-10-28	Male	{phone}	{email}	{street_address}
499	Bartie	Oldnall	2025-10-11	Male	{phone}	{email}	{street_address}
500	Johann	Saill	2026-03-26	Male	{phone}	{email}	{street_address}
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.payments (payment_id, amount, payment_date, payment_method, cardlast4, authcode, receiptno, patient_id) FROM stdin;
7001	150.00	2024-05-12	Credit Card	4422	098765	\N	1
7002	50.00	2024-05-12	Cash	\N	\N	A-102	2
\.


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.prescriptions (prescription_id, medication_name, dosage, issue_date, notes, visit_id) FROM stdin;
8001	Amlodipine	5mg once daily	2024-05-12	Take in the morning	9001
8002	Paracetamol	500mg as needed	2024-05-12	Max 4 times a day	9002
\.


--
-- Data for Name: visits_records; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.visits_records (visit_id, diagnosis, doctor_notes, temperature, blood_pressure, weight, pulse, follow_up_needed, appointment_id) FROM stdin;
9001	High Blood Pressure	Patient needs to reduce salt intake.	36.60	145/90	80.00	82	Yes	5001
9002	Common Cold	Rest and fluids recommended.	38.20	120/80	75.00	70	No	5002
3	Diagnosis_3	Notes_3	39.30	123/82	97.50	63	No	5003
4	Diagnosis_4	Notes_4	39.50	129/74	84.50	80	No	5004
5	Diagnosis_5	Notes_5	36.20	138/78	51.40	90	No	5005
6	Diagnosis_6	Notes_6	37.20	115/78	55.70	60	No	5006
7	Diagnosis_7	Notes_7	38.20	112/79	79.80	75	No	5007
8	Diagnosis_8	Notes_8	39.20	115/73	72.30	80	No	5008
9	Diagnosis_9	Notes_9	37.70	138/79	57.50	75	No	5009
10	Diagnosis_10	Notes_10	39.30	138/78	97.60	85	No	5010
11	Diagnosis_11	Notes_11	37.80	112/90	50.20	67	No	5011
12	Diagnosis_12	Notes_12	38.90	123/77	74.20	86	No	5012
13	Diagnosis_13	Notes_13	38.30	122/76	60.10	69	No	5013
14	Diagnosis_14	Notes_14	36.40	136/75	61.20	65	No	5014
15	Diagnosis_15	Notes_15	37.70	130/72	61.40	79	No	5015
16	Diagnosis_16	Notes_16	36.00	122/75	63.10	91	No	5016
17	Diagnosis_17	Notes_17	36.30	128/80	83.00	96	No	5017
18	Diagnosis_18	Notes_18	37.20	119/80	50.80	74	No	5018
19	Diagnosis_19	Notes_19	38.90	134/80	83.80	77	No	5019
20	Diagnosis_20	Notes_20	38.40	116/85	89.40	87	No	5020
21	Diagnosis_21	Notes_21	39.20	125/88	53.10	66	No	5021
22	Diagnosis_22	Notes_22	37.40	122/81	62.40	98	No	5022
23	Diagnosis_23	Notes_23	38.90	128/85	87.90	62	No	5023
24	Diagnosis_24	Notes_24	38.70	125/88	99.70	80	No	5024
25	Diagnosis_25	Notes_25	37.60	113/85	94.00	72	No	5025
26	Diagnosis_26	Notes_26	38.50	137/71	83.40	77	No	5026
27	Diagnosis_27	Notes_27	38.70	139/77	87.70	92	No	5027
28	Diagnosis_28	Notes_28	39.00	126/80	50.90	93	No	5028
29	Diagnosis_29	Notes_29	37.70	135/70	57.90	94	No	5029
30	Diagnosis_30	Notes_30	37.50	134/86	80.60	76	No	5030
31	Diagnosis_31	Notes_31	36.70	123/72	81.80	76	No	5031
32	Diagnosis_32	Notes_32	39.20	115/80	87.70	85	No	5032
33	Diagnosis_33	Notes_33	36.90	118/79	82.00	69	No	5033
34	Diagnosis_34	Notes_34	36.80	133/89	66.80	84	No	5034
35	Diagnosis_35	Notes_35	36.40	131/87	65.60	73	No	5035
36	Diagnosis_36	Notes_36	38.00	130/70	72.90	100	No	5036
37	Diagnosis_37	Notes_37	38.70	140/82	91.90	99	No	5037
38	Diagnosis_38	Notes_38	37.20	110/79	88.80	92	No	5038
39	Diagnosis_39	Notes_39	39.50	135/72	59.80	68	No	5039
40	Diagnosis_40	Notes_40	38.70	113/73	83.70	95	No	5040
41	Diagnosis_41	Notes_41	37.70	127/72	65.30	61	No	5041
42	Diagnosis_42	Notes_42	37.30	121/78	95.00	99	No	5042
43	Diagnosis_43	Notes_43	38.60	132/71	57.30	67	No	5043
44	Diagnosis_44	Notes_44	37.60	136/77	79.20	77	No	5044
45	Diagnosis_45	Notes_45	37.40	130/77	96.50	80	No	5045
46	Diagnosis_46	Notes_46	36.10	127/83	54.10	81	No	5046
47	Diagnosis_47	Notes_47	37.40	125/80	88.70	87	No	5047
48	Diagnosis_48	Notes_48	36.90	122/74	70.60	98	No	5048
49	Diagnosis_49	Notes_49	37.60	120/70	85.00	74	No	5049
50	Diagnosis_50	Notes_50	37.90	133/79	95.10	74	No	5050
51	Diagnosis_51	Notes_51	38.70	131/72	64.20	62	No	5051
52	Diagnosis_52	Notes_52	38.20	127/81	74.60	89	No	5052
53	Diagnosis_53	Notes_53	37.60	124/71	59.10	99	No	5053
54	Diagnosis_54	Notes_54	38.60	112/81	55.60	61	No	5054
55	Diagnosis_55	Notes_55	38.50	114/71	62.80	87	No	5055
56	Diagnosis_56	Notes_56	39.10	132/81	89.80	62	No	5056
57	Diagnosis_57	Notes_57	38.70	137/88	52.20	70	No	5057
58	Diagnosis_58	Notes_58	39.30	128/87	69.30	88	No	5058
59	Diagnosis_59	Notes_59	36.50	140/81	98.50	98	No	5059
60	Diagnosis_60	Notes_60	38.00	128/89	89.30	76	No	5060
61	Diagnosis_61	Notes_61	36.50	135/71	51.10	77	No	5061
62	Diagnosis_62	Notes_62	38.40	113/77	90.80	73	No	5062
63	Diagnosis_63	Notes_63	36.10	137/77	74.10	69	No	5063
64	Diagnosis_64	Notes_64	37.90	127/72	75.20	73	No	5064
65	Diagnosis_65	Notes_65	39.10	132/78	99.60	70	No	5065
66	Diagnosis_66	Notes_66	37.90	135/82	86.30	60	No	5066
67	Diagnosis_67	Notes_67	38.10	112/88	88.90	63	No	5067
68	Diagnosis_68	Notes_68	37.30	132/73	57.70	94	No	5068
69	Diagnosis_69	Notes_69	37.00	130/84	51.30	92	No	5069
70	Diagnosis_70	Notes_70	38.00	133/70	61.00	64	No	5070
71	Diagnosis_71	Notes_71	37.00	113/71	89.10	81	No	5071
72	Diagnosis_72	Notes_72	37.10	140/76	89.20	77	No	5072
73	Diagnosis_73	Notes_73	37.70	136/84	60.70	77	No	5073
74	Diagnosis_74	Notes_74	36.70	139/76	71.60	86	No	5074
75	Diagnosis_75	Notes_75	36.90	129/71	56.30	69	No	5075
76	Diagnosis_76	Notes_76	36.10	129/75	89.90	71	No	5076
77	Diagnosis_77	Notes_77	37.00	128/70	65.40	89	No	5077
78	Diagnosis_78	Notes_78	39.00	110/78	53.80	65	No	5078
79	Diagnosis_79	Notes_79	37.10	112/75	87.90	100	No	5079
80	Diagnosis_80	Notes_80	37.60	120/71	87.40	93	No	5080
81	Diagnosis_81	Notes_81	36.50	120/77	51.60	77	No	5081
82	Diagnosis_82	Notes_82	36.30	124/82	82.50	71	No	5082
83	Diagnosis_83	Notes_83	39.00	112/84	89.40	99	No	5083
84	Diagnosis_84	Notes_84	37.20	135/84	55.70	60	No	5084
85	Diagnosis_85	Notes_85	39.20	121/79	51.10	95	No	5085
86	Diagnosis_86	Notes_86	36.40	124/74	74.50	79	No	5086
87	Diagnosis_87	Notes_87	39.20	123/77	74.20	80	No	5087
88	Diagnosis_88	Notes_88	37.30	140/73	52.70	71	No	5088
89	Diagnosis_89	Notes_89	39.10	127/82	50.30	70	No	5089
90	Diagnosis_90	Notes_90	36.80	113/71	52.00	80	No	5090
91	Diagnosis_91	Notes_91	39.10	137/80	84.00	83	No	5091
92	Diagnosis_92	Notes_92	36.80	131/73	56.80	92	No	5092
93	Diagnosis_93	Notes_93	37.50	110/77	50.10	85	No	5093
94	Diagnosis_94	Notes_94	36.70	135/71	53.00	64	No	5094
95	Diagnosis_95	Notes_95	38.70	115/74	95.30	65	No	5095
96	Diagnosis_96	Notes_96	36.20	140/87	63.10	71	No	5096
97	Diagnosis_97	Notes_97	36.40	114/72	54.10	91	No	5097
98	Diagnosis_98	Notes_98	39.10	136/86	69.70	64	No	5098
99	Diagnosis_99	Notes_99	37.30	117/83	52.20	91	No	5099
100	Diagnosis_100	Notes_100	39.30	126/84	70.00	85	No	5100
101	Diagnosis_101	Notes_101	38.50	115/87	90.00	77	No	5101
102	Diagnosis_102	Notes_102	38.10	131/73	68.70	77	No	5102
103	Diagnosis_103	Notes_103	36.20	134/80	95.30	98	No	5103
104	Diagnosis_104	Notes_104	39.10	139/83	93.70	80	No	5104
105	Diagnosis_105	Notes_105	38.40	127/85	96.40	89	No	5105
106	Diagnosis_106	Notes_106	39.30	140/85	91.90	100	No	5106
107	Diagnosis_107	Notes_107	39.30	110/71	92.40	92	No	5107
108	Diagnosis_108	Notes_108	36.30	137/72	55.60	81	No	5108
109	Diagnosis_109	Notes_109	37.80	136/89	83.00	99	No	5109
110	Diagnosis_110	Notes_110	37.90	122/77	78.40	99	No	5110
111	Diagnosis_111	Notes_111	39.10	111/89	66.60	72	No	5111
112	Diagnosis_112	Notes_112	38.50	135/86	77.70	78	No	5112
113	Diagnosis_113	Notes_113	39.20	132/89	98.40	82	No	5113
114	Diagnosis_114	Notes_114	37.60	116/82	56.00	87	No	5114
115	Diagnosis_115	Notes_115	38.10	118/88	54.40	78	No	5115
116	Diagnosis_116	Notes_116	36.90	118/82	61.60	61	No	5116
117	Diagnosis_117	Notes_117	38.50	135/88	60.20	92	No	5117
118	Diagnosis_118	Notes_118	36.40	135/76	72.70	73	No	5118
119	Diagnosis_119	Notes_119	39.40	137/79	62.10	86	No	5119
120	Diagnosis_120	Notes_120	37.40	135/76	59.30	100	No	5120
121	Diagnosis_121	Notes_121	37.80	121/88	98.50	88	No	5121
122	Diagnosis_122	Notes_122	37.20	126/82	80.10	70	No	5122
123	Diagnosis_123	Notes_123	36.80	124/85	52.30	79	No	5123
124	Diagnosis_124	Notes_124	38.40	112/85	83.60	64	No	5124
125	Diagnosis_125	Notes_125	36.20	115/80	73.50	79	No	5125
126	Diagnosis_126	Notes_126	39.10	112/87	51.90	95	No	5126
127	Diagnosis_127	Notes_127	38.00	124/88	83.20	75	No	5127
128	Diagnosis_128	Notes_128	38.20	126/88	89.10	95	No	5128
129	Diagnosis_129	Notes_129	38.50	118/77	95.00	100	No	5129
130	Diagnosis_130	Notes_130	38.40	132/88	97.60	72	No	5130
131	Diagnosis_131	Notes_131	38.50	121/75	88.00	96	No	5131
132	Diagnosis_132	Notes_132	38.40	122/74	97.20	100	No	5132
133	Diagnosis_133	Notes_133	39.30	135/77	73.60	69	No	5133
134	Diagnosis_134	Notes_134	38.70	131/85	72.90	61	No	5134
135	Diagnosis_135	Notes_135	37.40	115/79	95.00	70	No	5135
136	Diagnosis_136	Notes_136	36.20	129/84	85.00	70	No	5136
137	Diagnosis_137	Notes_137	37.00	138/72	56.90	72	No	5137
138	Diagnosis_138	Notes_138	38.30	121/82	76.00	82	No	5138
139	Diagnosis_139	Notes_139	36.30	128/80	55.40	77	No	5139
140	Diagnosis_140	Notes_140	36.50	113/72	87.60	83	No	5140
141	Diagnosis_141	Notes_141	38.10	110/75	96.50	75	No	5141
142	Diagnosis_142	Notes_142	36.90	115/79	56.10	89	No	5142
143	Diagnosis_143	Notes_143	37.60	132/78	70.90	66	No	5143
144	Diagnosis_144	Notes_144	37.10	110/74	61.20	69	No	5144
145	Diagnosis_145	Notes_145	37.30	131/80	83.00	87	No	5145
146	Diagnosis_146	Notes_146	38.90	115/88	61.40	75	No	5146
147	Diagnosis_147	Notes_147	37.70	115/74	72.50	79	No	5147
148	Diagnosis_148	Notes_148	37.00	124/86	99.60	93	No	5148
149	Diagnosis_149	Notes_149	38.00	118/83	57.90	79	No	5149
150	Diagnosis_150	Notes_150	38.40	111/77	70.00	64	No	5150
151	Diagnosis_151	Notes_151	36.80	132/82	64.00	62	No	5151
152	Diagnosis_152	Notes_152	38.60	110/76	74.10	60	No	5152
153	Diagnosis_153	Notes_153	39.40	116/71	72.70	74	No	5153
154	Diagnosis_154	Notes_154	38.10	126/73	90.40	62	No	5154
155	Diagnosis_155	Notes_155	38.90	128/86	82.70	92	No	5155
156	Diagnosis_156	Notes_156	37.60	138/75	78.90	88	No	5156
157	Diagnosis_157	Notes_157	38.30	131/75	82.00	75	No	5157
158	Diagnosis_158	Notes_158	38.80	113/90	61.60	74	No	5158
159	Diagnosis_159	Notes_159	36.40	138/88	67.60	66	No	5159
160	Diagnosis_160	Notes_160	37.50	133/84	94.00	63	No	5160
161	Diagnosis_161	Notes_161	38.20	120/81	72.90	87	No	5161
162	Diagnosis_162	Notes_162	39.30	115/73	72.40	95	No	5162
163	Diagnosis_163	Notes_163	36.60	111/73	94.50	69	No	5163
164	Diagnosis_164	Notes_164	36.90	127/78	76.40	79	No	5164
165	Diagnosis_165	Notes_165	37.30	127/89	100.00	92	No	5165
166	Diagnosis_166	Notes_166	39.30	114/72	53.50	72	No	5166
167	Diagnosis_167	Notes_167	36.20	130/70	90.40	100	No	5167
168	Diagnosis_168	Notes_168	37.60	132/74	69.50	73	No	5168
169	Diagnosis_169	Notes_169	38.80	127/73	68.90	84	No	5169
170	Diagnosis_170	Notes_170	37.00	115/89	73.20	86	No	5170
171	Diagnosis_171	Notes_171	38.70	115/87	75.90	76	No	5171
172	Diagnosis_172	Notes_172	36.30	116/86	68.90	85	No	5172
173	Diagnosis_173	Notes_173	38.10	118/79	54.90	77	No	5173
174	Diagnosis_174	Notes_174	39.30	124/76	82.90	65	No	5174
175	Diagnosis_175	Notes_175	36.20	139/80	84.40	88	No	5175
176	Diagnosis_176	Notes_176	36.70	113/85	59.50	71	No	5176
177	Diagnosis_177	Notes_177	37.50	112/87	77.20	73	No	5177
178	Diagnosis_178	Notes_178	36.20	122/88	73.60	68	No	5178
179	Diagnosis_179	Notes_179	38.40	129/70	80.20	98	No	5179
180	Diagnosis_180	Notes_180	38.70	133/77	59.00	65	No	5180
181	Diagnosis_181	Notes_181	36.30	111/72	66.50	97	No	5181
182	Diagnosis_182	Notes_182	38.90	130/90	99.90	65	No	5182
183	Diagnosis_183	Notes_183	36.80	121/86	98.80	62	No	5183
184	Diagnosis_184	Notes_184	38.20	116/71	64.30	67	No	5184
185	Diagnosis_185	Notes_185	39.50	138/76	68.80	83	No	5185
186	Diagnosis_186	Notes_186	38.60	130/76	87.10	99	No	5186
187	Diagnosis_187	Notes_187	37.00	130/81	99.70	63	No	5187
188	Diagnosis_188	Notes_188	39.20	137/72	81.70	81	No	5188
189	Diagnosis_189	Notes_189	38.40	113/73	67.30	79	No	5189
190	Diagnosis_190	Notes_190	38.00	119/76	59.40	96	No	5190
191	Diagnosis_191	Notes_191	36.30	117/89	65.40	79	No	5191
192	Diagnosis_192	Notes_192	36.50	131/84	53.40	100	No	5192
193	Diagnosis_193	Notes_193	36.50	111/89	92.10	63	No	5193
194	Diagnosis_194	Notes_194	38.10	112/84	72.50	63	No	5194
195	Diagnosis_195	Notes_195	36.50	139/75	54.40	67	No	5195
196	Diagnosis_196	Notes_196	38.50	120/72	85.90	89	No	5196
197	Diagnosis_197	Notes_197	38.60	130/72	84.70	62	No	5197
198	Diagnosis_198	Notes_198	36.90	135/89	72.50	61	No	5198
199	Diagnosis_199	Notes_199	37.90	126/87	78.50	96	No	5199
200	Diagnosis_200	Notes_200	36.80	123/73	72.90	78	No	5200
201	Diagnosis_201	Notes_201	37.40	128/72	67.30	87	No	5201
202	Diagnosis_202	Notes_202	36.40	133/84	98.40	65	No	5202
203	Diagnosis_203	Notes_203	36.50	118/90	62.40	63	No	5203
204	Diagnosis_204	Notes_204	39.20	112/73	92.20	92	No	5204
205	Diagnosis_205	Notes_205	39.40	114/73	93.40	75	No	5205
206	Diagnosis_206	Notes_206	38.40	130/82	63.90	62	No	5206
207	Diagnosis_207	Notes_207	36.90	116/85	59.50	68	No	5207
208	Diagnosis_208	Notes_208	37.90	118/79	81.60	75	No	5208
209	Diagnosis_209	Notes_209	37.40	140/75	88.00	81	No	5209
210	Diagnosis_210	Notes_210	37.60	125/90	68.00	98	No	5210
211	Diagnosis_211	Notes_211	39.20	117/77	57.80	82	No	5211
212	Diagnosis_212	Notes_212	36.30	124/78	51.20	70	No	5212
213	Diagnosis_213	Notes_213	36.10	131/78	59.60	78	No	5213
214	Diagnosis_214	Notes_214	38.90	130/77	70.70	67	No	5214
215	Diagnosis_215	Notes_215	37.60	120/90	93.50	62	No	5215
216	Diagnosis_216	Notes_216	39.30	127/85	63.60	96	No	5216
217	Diagnosis_217	Notes_217	38.50	121/86	96.90	82	No	5217
218	Diagnosis_218	Notes_218	36.60	140/70	60.40	61	No	5218
219	Diagnosis_219	Notes_219	38.40	126/70	78.60	91	No	5219
220	Diagnosis_220	Notes_220	36.60	131/82	58.70	93	No	5220
221	Diagnosis_221	Notes_221	39.40	112/89	59.20	65	No	5221
222	Diagnosis_222	Notes_222	36.10	126/81	51.20	66	No	5222
223	Diagnosis_223	Notes_223	36.00	134/79	96.20	86	No	5223
224	Diagnosis_224	Notes_224	38.20	117/72	53.30	89	No	5224
225	Diagnosis_225	Notes_225	38.90	115/89	89.10	83	No	5225
226	Diagnosis_226	Notes_226	36.20	120/79	53.00	79	No	5226
227	Diagnosis_227	Notes_227	36.30	130/77	56.10	70	No	5227
228	Diagnosis_228	Notes_228	36.00	117/90	93.90	71	No	5228
229	Diagnosis_229	Notes_229	37.50	121/87	84.50	91	No	5229
230	Diagnosis_230	Notes_230	39.10	124/72	50.10	81	No	5230
231	Diagnosis_231	Notes_231	36.30	133/70	86.70	90	No	5231
232	Diagnosis_232	Notes_232	38.60	127/77	68.00	76	No	5232
233	Diagnosis_233	Notes_233	38.70	120/80	53.10	79	No	5233
234	Diagnosis_234	Notes_234	38.60	121/75	99.30	60	No	5234
235	Diagnosis_235	Notes_235	37.20	123/70	97.80	64	No	5235
236	Diagnosis_236	Notes_236	39.00	121/70	66.90	61	No	5236
237	Diagnosis_237	Notes_237	38.60	111/85	64.90	72	No	5237
238	Diagnosis_238	Notes_238	37.00	132/86	76.60	78	No	5238
239	Diagnosis_239	Notes_239	36.10	131/85	84.00	66	No	5239
240	Diagnosis_240	Notes_240	39.10	120/75	85.20	78	No	5240
241	Diagnosis_241	Notes_241	37.40	133/74	66.10	68	No	5241
242	Diagnosis_242	Notes_242	37.90	110/77	98.10	82	No	5242
243	Diagnosis_243	Notes_243	36.30	129/78	63.60	97	No	5243
244	Diagnosis_244	Notes_244	38.00	111/76	63.70	70	No	5244
245	Diagnosis_245	Notes_245	36.70	137/74	86.00	98	No	5245
246	Diagnosis_246	Notes_246	36.20	120/77	73.60	86	No	5246
247	Diagnosis_247	Notes_247	39.40	112/87	72.80	70	No	5247
248	Diagnosis_248	Notes_248	36.30	138/83	73.60	61	No	5248
249	Diagnosis_249	Notes_249	37.70	122/88	97.80	75	No	5249
250	Diagnosis_250	Notes_250	38.70	113/70	65.60	78	No	5250
251	Diagnosis_251	Notes_251	37.10	128/83	79.60	88	No	5251
252	Diagnosis_252	Notes_252	37.90	133/85	67.30	96	No	5252
253	Diagnosis_253	Notes_253	39.50	135/88	52.20	69	No	5253
254	Diagnosis_254	Notes_254	38.40	137/81	68.90	95	No	5254
255	Diagnosis_255	Notes_255	38.70	135/79	52.80	87	No	5255
256	Diagnosis_256	Notes_256	37.30	131/76	66.70	76	No	5256
257	Diagnosis_257	Notes_257	38.60	126/78	85.30	89	No	5257
258	Diagnosis_258	Notes_258	36.70	120/87	90.20	62	No	5258
259	Diagnosis_259	Notes_259	39.20	123/85	70.20	98	No	5259
260	Diagnosis_260	Notes_260	38.30	113/87	70.10	60	No	5260
261	Diagnosis_261	Notes_261	37.30	124/72	93.30	72	No	5261
262	Diagnosis_262	Notes_262	38.30	140/81	64.90	99	No	5262
263	Diagnosis_263	Notes_263	37.70	118/80	94.20	87	No	5263
264	Diagnosis_264	Notes_264	39.00	133/70	62.40	92	No	5264
265	Diagnosis_265	Notes_265	38.40	132/76	53.00	66	No	5265
266	Diagnosis_266	Notes_266	37.70	129/86	66.40	74	No	5266
267	Diagnosis_267	Notes_267	38.70	118/88	68.30	77	No	5267
268	Diagnosis_268	Notes_268	37.00	130/75	87.00	87	No	5268
269	Diagnosis_269	Notes_269	36.50	116/86	68.50	67	No	5269
270	Diagnosis_270	Notes_270	36.60	124/83	61.70	98	No	5270
271	Diagnosis_271	Notes_271	38.50	123/70	81.70	78	No	5271
272	Diagnosis_272	Notes_272	36.90	124/90	85.30	80	No	5272
273	Diagnosis_273	Notes_273	37.10	131/72	89.60	62	No	5273
274	Diagnosis_274	Notes_274	37.50	137/71	94.80	80	No	5274
275	Diagnosis_275	Notes_275	36.50	136/74	76.90	69	No	5275
276	Diagnosis_276	Notes_276	39.50	130/77	95.40	64	No	5276
277	Diagnosis_277	Notes_277	36.40	131/79	51.50	72	No	5277
278	Diagnosis_278	Notes_278	38.00	111/83	96.00	80	No	5278
279	Diagnosis_279	Notes_279	36.90	133/83	55.80	84	No	5279
280	Diagnosis_280	Notes_280	38.00	127/77	54.10	83	No	5280
281	Diagnosis_281	Notes_281	38.50	118/76	87.10	77	No	5281
282	Diagnosis_282	Notes_282	37.10	112/85	99.70	63	No	5282
283	Diagnosis_283	Notes_283	36.70	116/87	72.90	87	No	5283
284	Diagnosis_284	Notes_284	38.10	124/77	74.70	86	No	5284
285	Diagnosis_285	Notes_285	39.40	133/75	54.00	85	No	5285
286	Diagnosis_286	Notes_286	38.60	120/73	83.00	82	No	5286
287	Diagnosis_287	Notes_287	39.10	113/77	64.90	90	No	5287
288	Diagnosis_288	Notes_288	37.00	113/86	73.20	79	No	5288
289	Diagnosis_289	Notes_289	37.90	134/73	68.10	86	No	5289
290	Diagnosis_290	Notes_290	36.90	135/80	80.30	72	No	5290
291	Diagnosis_291	Notes_291	39.30	128/78	83.70	73	No	5291
292	Diagnosis_292	Notes_292	38.90	138/76	53.00	62	No	5292
293	Diagnosis_293	Notes_293	38.60	122/86	99.30	100	No	5293
294	Diagnosis_294	Notes_294	37.10	117/83	50.50	80	No	5294
295	Diagnosis_295	Notes_295	38.60	140/72	63.10	96	No	5295
296	Diagnosis_296	Notes_296	36.60	112/87	74.80	87	No	5296
297	Diagnosis_297	Notes_297	36.20	118/71	51.20	70	No	5297
298	Diagnosis_298	Notes_298	37.90	113/80	64.60	68	No	5298
299	Diagnosis_299	Notes_299	36.50	135/83	87.20	60	No	5299
300	Diagnosis_300	Notes_300	38.00	137/90	67.10	77	No	5300
301	Diagnosis_301	Notes_301	39.40	131/80	83.90	86	No	5301
302	Diagnosis_302	Notes_302	36.40	115/85	53.70	83	No	5302
303	Diagnosis_303	Notes_303	37.70	131/73	52.50	68	No	5303
304	Diagnosis_304	Notes_304	37.00	120/82	74.40	74	No	5304
305	Diagnosis_305	Notes_305	36.10	134/87	72.70	76	No	5305
306	Diagnosis_306	Notes_306	36.10	129/90	81.10	79	No	5306
307	Diagnosis_307	Notes_307	36.80	128/79	81.90	90	No	5307
308	Diagnosis_308	Notes_308	36.80	120/80	78.50	63	No	5308
309	Diagnosis_309	Notes_309	38.80	132/71	94.10	61	No	5309
310	Diagnosis_310	Notes_310	39.30	133/77	61.80	62	No	5310
311	Diagnosis_311	Notes_311	36.00	139/78	85.40	83	No	5311
312	Diagnosis_312	Notes_312	39.20	122/79	99.60	66	No	5312
313	Diagnosis_313	Notes_313	36.20	137/87	54.80	68	No	5313
314	Diagnosis_314	Notes_314	36.90	112/73	94.40	80	No	5314
315	Diagnosis_315	Notes_315	39.30	127/76	62.40	84	No	5315
316	Diagnosis_316	Notes_316	36.10	122/90	51.00	66	No	5316
317	Diagnosis_317	Notes_317	36.30	139/83	93.60	66	No	5317
318	Diagnosis_318	Notes_318	38.00	125/84	93.90	73	No	5318
319	Diagnosis_319	Notes_319	38.70	119/86	82.50	71	No	5319
320	Diagnosis_320	Notes_320	37.50	120/84	79.20	73	No	5320
321	Diagnosis_321	Notes_321	36.40	132/70	96.80	79	No	5321
322	Diagnosis_322	Notes_322	38.20	134/78	60.90	69	No	5322
323	Diagnosis_323	Notes_323	36.40	128/87	51.20	99	No	5323
324	Diagnosis_324	Notes_324	37.80	138/79	89.50	67	No	5324
325	Diagnosis_325	Notes_325	36.00	119/89	82.10	64	No	5325
326	Diagnosis_326	Notes_326	36.20	122/77	95.50	98	No	5326
327	Diagnosis_327	Notes_327	36.60	121/84	85.60	96	No	5327
328	Diagnosis_328	Notes_328	38.50	116/72	74.60	73	No	5328
329	Diagnosis_329	Notes_329	37.10	135/81	50.80	87	No	5329
330	Diagnosis_330	Notes_330	39.00	117/76	70.00	70	No	5330
331	Diagnosis_331	Notes_331	38.10	130/79	87.50	99	No	5331
332	Diagnosis_332	Notes_332	36.80	114/79	56.90	75	No	5332
333	Diagnosis_333	Notes_333	37.30	130/90	54.40	97	No	5333
334	Diagnosis_334	Notes_334	38.80	110/79	79.00	63	No	5334
335	Diagnosis_335	Notes_335	36.40	135/78	88.80	90	No	5335
336	Diagnosis_336	Notes_336	38.90	137/70	88.80	69	No	5336
337	Diagnosis_337	Notes_337	37.30	118/83	60.10	96	No	5337
338	Diagnosis_338	Notes_338	36.30	118/72	74.10	97	No	5338
339	Diagnosis_339	Notes_339	37.10	123/89	55.30	64	No	5339
340	Diagnosis_340	Notes_340	39.50	119/74	89.40	66	No	5340
341	Diagnosis_341	Notes_341	37.80	114/82	70.10	90	No	5341
342	Diagnosis_342	Notes_342	36.90	135/70	59.30	92	No	5342
343	Diagnosis_343	Notes_343	36.70	124/80	83.70	62	No	5343
344	Diagnosis_344	Notes_344	38.00	120/80	86.50	78	No	5344
345	Diagnosis_345	Notes_345	37.60	116/85	50.60	85	No	5345
346	Diagnosis_346	Notes_346	38.90	140/84	92.20	93	No	5346
347	Diagnosis_347	Notes_347	39.10	121/81	74.90	84	No	5347
348	Diagnosis_348	Notes_348	39.20	119/80	85.80	61	No	5348
349	Diagnosis_349	Notes_349	36.60	115/85	57.60	69	No	5349
350	Diagnosis_350	Notes_350	36.70	116/90	85.00	89	No	5350
351	Diagnosis_351	Notes_351	38.70	123/71	61.00	89	No	5351
352	Diagnosis_352	Notes_352	39.20	134/89	97.10	64	No	5352
353	Diagnosis_353	Notes_353	36.70	124/84	68.80	91	No	5353
354	Diagnosis_354	Notes_354	39.00	118/74	76.00	64	No	5354
355	Diagnosis_355	Notes_355	38.00	122/82	91.30	72	No	5355
356	Diagnosis_356	Notes_356	36.30	119/90	57.70	74	No	5356
357	Diagnosis_357	Notes_357	38.70	127/76	89.10	92	No	5357
358	Diagnosis_358	Notes_358	37.20	133/87	78.00	76	No	5358
359	Diagnosis_359	Notes_359	39.00	121/77	58.10	92	No	5359
360	Diagnosis_360	Notes_360	39.20	136/76	81.50	75	No	5360
361	Diagnosis_361	Notes_361	38.30	125/83	53.80	87	No	5361
362	Diagnosis_362	Notes_362	38.70	110/84	93.50	91	No	5362
363	Diagnosis_363	Notes_363	37.70	117/83	81.80	77	No	5363
364	Diagnosis_364	Notes_364	39.40	129/90	95.40	81	No	5364
365	Diagnosis_365	Notes_365	37.70	119/90	54.20	94	No	5365
366	Diagnosis_366	Notes_366	39.30	140/70	62.20	81	No	5366
367	Diagnosis_367	Notes_367	38.40	128/80	93.60	77	No	5367
368	Diagnosis_368	Notes_368	37.10	129/83	74.40	68	No	5368
369	Diagnosis_369	Notes_369	37.80	134/83	58.10	70	No	5369
370	Diagnosis_370	Notes_370	39.30	114/87	82.00	83	No	5370
371	Diagnosis_371	Notes_371	39.30	132/85	66.10	63	No	5371
372	Diagnosis_372	Notes_372	37.10	139/80	76.60	99	No	5372
373	Diagnosis_373	Notes_373	36.40	112/88	96.70	74	No	5373
374	Diagnosis_374	Notes_374	38.10	117/85	74.20	85	No	5374
375	Diagnosis_375	Notes_375	37.20	117/84	72.50	73	No	5375
376	Diagnosis_376	Notes_376	36.10	115/72	82.70	89	No	5376
377	Diagnosis_377	Notes_377	36.40	114/75	52.40	74	No	5377
378	Diagnosis_378	Notes_378	36.20	115/71	66.30	81	No	5378
379	Diagnosis_379	Notes_379	36.20	115/87	62.20	98	No	5379
380	Diagnosis_380	Notes_380	37.40	130/70	54.60	76	No	5380
381	Diagnosis_381	Notes_381	37.50	130/78	71.50	63	No	5381
382	Diagnosis_382	Notes_382	37.30	112/88	89.80	99	No	5382
383	Diagnosis_383	Notes_383	37.30	122/76	91.30	75	No	5383
384	Diagnosis_384	Notes_384	38.80	121/77	76.20	85	No	5384
385	Diagnosis_385	Notes_385	38.20	137/75	93.70	90	No	5385
386	Diagnosis_386	Notes_386	38.10	128/89	96.20	81	No	5386
387	Diagnosis_387	Notes_387	38.40	111/71	68.10	62	No	5387
388	Diagnosis_388	Notes_388	38.70	120/70	79.80	75	No	5388
389	Diagnosis_389	Notes_389	38.00	114/74	82.10	64	No	5389
390	Diagnosis_390	Notes_390	37.30	110/81	91.40	61	No	5390
391	Diagnosis_391	Notes_391	39.30	126/88	94.90	77	No	5391
392	Diagnosis_392	Notes_392	36.00	125/80	79.30	67	No	5392
393	Diagnosis_393	Notes_393	36.00	118/80	90.40	98	No	5393
394	Diagnosis_394	Notes_394	38.40	122/78	96.70	80	No	5394
395	Diagnosis_395	Notes_395	38.30	116/81	53.20	82	No	5395
396	Diagnosis_396	Notes_396	39.30	110/74	61.00	76	No	5396
397	Diagnosis_397	Notes_397	37.40	124/88	74.70	79	No	5397
398	Diagnosis_398	Notes_398	39.50	114/79	91.50	96	No	5398
399	Diagnosis_399	Notes_399	37.10	129/90	82.70	61	No	5399
400	Diagnosis_400	Notes_400	38.00	114/85	86.60	87	No	5400
401	Diagnosis_401	Notes_401	37.70	110/74	94.40	67	No	5401
402	Diagnosis_402	Notes_402	38.60	140/79	55.70	60	No	5402
403	Diagnosis_403	Notes_403	39.20	115/80	54.10	65	No	5403
404	Diagnosis_404	Notes_404	38.00	130/89	78.10	93	No	5404
405	Diagnosis_405	Notes_405	39.30	128/80	98.20	76	No	5405
406	Diagnosis_406	Notes_406	37.90	128/84	78.00	87	No	5406
407	Diagnosis_407	Notes_407	39.20	135/70	52.10	70	No	5407
408	Diagnosis_408	Notes_408	38.00	129/85	96.20	85	No	5408
409	Diagnosis_409	Notes_409	36.10	116/79	96.00	65	No	5409
410	Diagnosis_410	Notes_410	36.80	122/86	76.90	61	No	5410
411	Diagnosis_411	Notes_411	37.20	128/87	67.90	90	No	5411
412	Diagnosis_412	Notes_412	37.70	112/88	75.00	78	No	5412
413	Diagnosis_413	Notes_413	38.00	111/72	95.30	77	No	5413
414	Diagnosis_414	Notes_414	37.30	132/90	61.70	70	No	5414
415	Diagnosis_415	Notes_415	36.70	134/82	95.10	83	No	5415
416	Diagnosis_416	Notes_416	37.40	127/79	92.00	73	No	5416
417	Diagnosis_417	Notes_417	37.30	118/79	92.60	76	No	5417
418	Diagnosis_418	Notes_418	38.50	128/84	86.20	71	No	5418
419	Diagnosis_419	Notes_419	39.20	135/86	61.00	70	No	5419
420	Diagnosis_420	Notes_420	38.90	116/75	66.70	92	No	5420
421	Diagnosis_421	Notes_421	36.70	114/82	67.30	79	No	5421
422	Diagnosis_422	Notes_422	39.00	134/73	54.60	79	No	5422
423	Diagnosis_423	Notes_423	37.50	113/80	69.20	64	No	5423
424	Diagnosis_424	Notes_424	39.00	138/89	80.80	80	No	5424
425	Diagnosis_425	Notes_425	36.30	132/79	55.50	100	No	5425
426	Diagnosis_426	Notes_426	36.80	118/84	96.10	62	No	5426
427	Diagnosis_427	Notes_427	37.20	119/76	72.90	98	No	5427
428	Diagnosis_428	Notes_428	38.20	117/88	64.40	61	No	5428
429	Diagnosis_429	Notes_429	36.70	126/82	81.40	74	No	5429
430	Diagnosis_430	Notes_430	37.60	126/74	68.90	66	No	5430
431	Diagnosis_431	Notes_431	37.10	129/72	80.20	77	No	5431
432	Diagnosis_432	Notes_432	37.50	130/74	70.00	98	No	5432
433	Diagnosis_433	Notes_433	38.20	129/73	69.50	64	No	5433
434	Diagnosis_434	Notes_434	39.20	133/75	92.40	66	No	5434
435	Diagnosis_435	Notes_435	36.60	126/83	80.80	92	No	5435
436	Diagnosis_436	Notes_436	36.50	122/75	68.40	73	No	5436
437	Diagnosis_437	Notes_437	38.70	130/86	98.00	81	No	5437
438	Diagnosis_438	Notes_438	37.90	124/74	90.00	67	No	5438
439	Diagnosis_439	Notes_439	36.60	115/90	51.60	73	No	5439
440	Diagnosis_440	Notes_440	37.60	128/82	69.80	88	No	5440
441	Diagnosis_441	Notes_441	37.90	130/81	65.90	87	No	5441
442	Diagnosis_442	Notes_442	37.90	134/70	78.90	91	No	5442
443	Diagnosis_443	Notes_443	38.70	121/74	80.50	67	No	5443
444	Diagnosis_444	Notes_444	36.80	133/70	56.60	98	No	5444
445	Diagnosis_445	Notes_445	37.50	134/89	72.60	84	No	5445
446	Diagnosis_446	Notes_446	39.00	115/82	69.60	89	No	5446
447	Diagnosis_447	Notes_447	38.70	117/81	53.60	70	No	5447
448	Diagnosis_448	Notes_448	37.60	125/83	53.90	91	No	5448
449	Diagnosis_449	Notes_449	37.80	123/77	82.10	69	No	5449
450	Diagnosis_450	Notes_450	38.40	132/79	84.70	63	No	5450
451	Diagnosis_451	Notes_451	38.30	111/83	96.40	97	No	5451
452	Diagnosis_452	Notes_452	36.80	124/70	89.10	65	No	5452
453	Diagnosis_453	Notes_453	37.60	120/88	94.70	76	No	5453
454	Diagnosis_454	Notes_454	36.00	120/87	50.20	63	No	5454
455	Diagnosis_455	Notes_455	37.60	124/82	69.50	95	No	5455
456	Diagnosis_456	Notes_456	38.50	135/76	59.30	89	No	5456
457	Diagnosis_457	Notes_457	36.60	115/75	69.30	88	No	5457
458	Diagnosis_458	Notes_458	39.40	135/74	97.30	86	No	5458
459	Diagnosis_459	Notes_459	36.60	121/85	68.80	72	No	5459
460	Diagnosis_460	Notes_460	36.40	133/90	58.50	78	No	5460
461	Diagnosis_461	Notes_461	37.70	139/84	53.90	71	No	5461
462	Diagnosis_462	Notes_462	38.40	121/78	63.20	67	No	5462
463	Diagnosis_463	Notes_463	39.50	113/70	62.90	86	No	5463
464	Diagnosis_464	Notes_464	38.80	117/83	76.00	78	No	5464
465	Diagnosis_465	Notes_465	36.80	117/87	73.00	97	No	5465
466	Diagnosis_466	Notes_466	36.30	118/87	98.40	72	No	5466
467	Diagnosis_467	Notes_467	36.70	123/86	55.90	68	No	5467
468	Diagnosis_468	Notes_468	36.10	113/82	85.90	93	No	5468
469	Diagnosis_469	Notes_469	36.90	117/79	61.60	68	No	5469
470	Diagnosis_470	Notes_470	38.10	117/84	60.10	91	No	5470
471	Diagnosis_471	Notes_471	39.40	117/78	91.40	87	No	5471
472	Diagnosis_472	Notes_472	36.80	123/86	82.20	89	No	5472
473	Diagnosis_473	Notes_473	37.40	127/73	85.20	94	No	5473
474	Diagnosis_474	Notes_474	37.40	131/85	74.70	86	No	5474
475	Diagnosis_475	Notes_475	39.10	110/73	71.40	80	No	5475
476	Diagnosis_476	Notes_476	39.20	117/72	91.10	67	No	5476
477	Diagnosis_477	Notes_477	36.90	122/82	92.40	83	No	5477
478	Diagnosis_478	Notes_478	36.80	139/88	79.70	61	No	5478
479	Diagnosis_479	Notes_479	39.00	124/90	73.80	72	No	5479
480	Diagnosis_480	Notes_480	37.30	118/75	70.20	78	No	5480
481	Diagnosis_481	Notes_481	38.10	137/75	82.10	65	No	5481
482	Diagnosis_482	Notes_482	38.20	115/86	79.80	82	No	5482
483	Diagnosis_483	Notes_483	37.70	122/90	74.50	87	No	5483
484	Diagnosis_484	Notes_484	36.80	137/70	56.70	74	No	5484
485	Diagnosis_485	Notes_485	37.70	111/70	85.40	95	No	5485
486	Diagnosis_486	Notes_486	38.40	114/75	55.20	82	No	5486
487	Diagnosis_487	Notes_487	36.40	127/83	83.20	78	No	5487
488	Diagnosis_488	Notes_488	37.90	119/83	79.40	73	No	5488
489	Diagnosis_489	Notes_489	37.10	134/80	91.40	86	No	5489
490	Diagnosis_490	Notes_490	36.20	120/85	79.00	79	No	5490
491	Diagnosis_491	Notes_491	37.90	122/72	97.30	85	No	5491
492	Diagnosis_492	Notes_492	38.20	132/88	87.00	87	No	5492
493	Diagnosis_493	Notes_493	37.50	123/77	73.40	74	No	5493
494	Diagnosis_494	Notes_494	36.50	129/72	65.90	98	No	5494
495	Diagnosis_495	Notes_495	36.50	127/83	89.60	87	No	5495
496	Diagnosis_496	Notes_496	38.10	140/82	75.10	60	No	5496
497	Diagnosis_497	Notes_497	39.20	134/89	97.20	72	No	5497
498	Diagnosis_498	Notes_498	38.30	110/77	56.30	96	No	5498
499	Diagnosis_499	Notes_499	38.70	126/72	55.40	83	No	5499
500	Diagnosis_500	Notes_500	39.40	135/76	66.60	62	No	5000
\.


--
-- Name: doctor_working_hours_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.doctor_working_hours_schedule_id_seq', 198, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);


--
-- Name: doctor_working_hours doctor_working_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.doctor_working_hours
    ADD CONSTRAINT doctor_working_hours_pkey PRIMARY KEY (schedule_id);


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (license_number);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (prescription_id);


--
-- Name: visits_records visits_records_appointment_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.visits_records
    ADD CONSTRAINT visits_records_appointment_id_key UNIQUE (appointment_id);


--
-- Name: visits_records visits_records_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.visits_records
    ADD CONSTRAINT visits_records_pkey PRIMARY KEY (visit_id);


--
-- Name: appointments appointments_license_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_license_number_fkey FOREIGN KEY (license_number) REFERENCES public.doctors(license_number);


--
-- Name: appointments appointments_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: doctor_working_hours doctor_working_hours_license_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.doctor_working_hours
    ADD CONSTRAINT doctor_working_hours_license_number_fkey FOREIGN KEY (license_number) REFERENCES public.doctors(license_number);


--
-- Name: payments payments_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: prescriptions prescriptions_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES public.visits_records(visit_id);


--
-- Name: visits_records visits_records_appointment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.visits_records
    ADD CONSTRAINT visits_records_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id);


--
-- PostgreSQL database dump complete
--

