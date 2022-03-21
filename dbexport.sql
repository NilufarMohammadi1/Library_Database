--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Book" (
    "BookID" uuid NOT NULL,
    "Name" character varying(100) NOT NULL,
    "Author" character varying(100) NOT NULL,
    "BookCount" integer,
    "AddedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "Status" character varying(50) NOT NULL,
    "Description" text,
    "PublisherID" uuid NOT NULL,
    "CategoryID" uuid NOT NULL
);


ALTER TABLE public."Book" OWNER TO postgres;

--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    "CategoryID" uuid NOT NULL,
    "Name" character varying(100) NOT NULL,
    "CreatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "ModifiedAt" timestamp without time zone,
    "Status" smallint NOT NULL,
    "Description" text,
    "Parent" uuid
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: BookCategory; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."BookCategory" AS
 SELECT "Book"."Name" AS "Book Name",
    "Category"."Name" AS "Category Name"
   FROM (public."Book"
     JOIN public."Category" ON (("Category"."CategoryID" = "Book"."CategoryID")));


ALTER TABLE public."BookCategory" OWNER TO postgres;

--
-- Name: Borrow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Borrow" (
    "BorrowID" uuid NOT NULL,
    "UserID" uuid NOT NULL,
    "BookID" uuid NOT NULL,
    "BorrowDate" date DEFAULT now() NOT NULL,
    "Status" smallint NOT NULL,
    "Description" text
);


ALTER TABLE public."Borrow" OWNER TO postgres;

--
-- Name: Publisher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Publisher" (
    "PublisherID" uuid NOT NULL,
    "Name" character varying(100) NOT NULL,
    "CreatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "ModifiedAt" timestamp without time zone,
    "Status" smallint NOT NULL,
    "Description" text,
    "PublishDate" timestamp without time zone NOT NULL
);


ALTER TABLE public."Publisher" OWNER TO postgres;

--
-- Name: Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Role" (
    "RoleID" uuid NOT NULL,
    "Name" character varying(50) NOT NULL,
    "CreatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "ModifiedAt" timestamp without time zone,
    "Status" character varying(50) NOT NULL,
    "Description" text
);


ALTER TABLE public."Role" OWNER TO postgres;

--
-- Name: Section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Section" (
    "SectionID" uuid NOT NULL,
    "Name" character varying(100) NOT NULL,
    "BookID" uuid NOT NULL,
    "CreatedAt" timestamp without time zone NOT NULL,
    "ModifiedAt" timestamp without time zone,
    "Status" smallint NOT NULL,
    "Description" text
);


ALTER TABLE public."Section" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "UserID" uuid NOT NULL,
    "Firstname" character varying(50) NOT NULL,
    "Lastname" character varying(50) NOT NULL,
    "StudentNumber" integer,
    "NationalCivilCode" character varying(10) NOT NULL,
    "Birthday" date NOT NULL,
    "FatherName" character varying(50) NOT NULL,
    "Email" character varying(100),
    "RoleID" uuid NOT NULL,
    "CreatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "ModifiedAt" timestamp without time zone,
    "Status" character varying(50) NOT NULL,
    "Description" text
);


ALTER TABLE public."User" OWNER TO postgres;


--
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY ("BookID");


--
-- Name: Borrow Borrow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow"
    ADD CONSTRAINT "Borrow_pkey" PRIMARY KEY ("BorrowID");


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY ("CategoryID");


--
-- Name: User NationalCivilCode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "NationalCivilCode" UNIQUE ("NationalCivilCode");


--
-- Name: Publisher Publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Publisher"
    ADD CONSTRAINT "Publisher_pkey" PRIMARY KEY ("PublisherID");


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY ("RoleID");


--
-- Name: Section Section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Section"
    ADD CONSTRAINT "Section_pkey" PRIMARY KEY ("SectionID");


--
-- Name: User StudentNumber; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "StudentNumber" UNIQUE ("StudentNumber");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserID");


--
-- Name: Borrow BookID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow"
    ADD CONSTRAINT "BookID" FOREIGN KEY ("BookID") REFERENCES public."Book"("BookID") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: Section BookID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Section"
    ADD CONSTRAINT "BookID" FOREIGN KEY ("BookID") REFERENCES public."Book"("BookID") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: Borrow BorrowID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Borrow"
    ADD CONSTRAINT "BorrowID" FOREIGN KEY ("UserID") REFERENCES public."User"("UserID") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: Book CategoryID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "CategoryID" FOREIGN KEY ("CategoryID") REFERENCES public."Category"("CategoryID") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: Book PublisherID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "PublisherID" FOREIGN KEY ("PublisherID") REFERENCES public."Publisher"("PublisherID") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- Name: User RoleID; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "RoleID" FOREIGN KEY ("RoleID") REFERENCES public."Role"("RoleID") ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- PostgreSQL database dump complete
--

