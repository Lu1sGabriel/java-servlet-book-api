-- Tabela do usuário.

CREATE TABLE "user"
(
    userId   BIGSERIAL,
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR      NOT NULL UNIQUE,
    phno     VARCHAR(11)  NOT NULL,
    password VARCHAR      NOT NULL,
    adress   VARCHAR(45),
    landmark VARCHAR(45),
    city     VARCHAR(45),
    state    VARCHAR(45),
    pincode  VARCHAR(11),
    CONSTRAINT userKey PRIMARY KEY (userId)
);

SELECT *
FROM public.user;

-- Tabela papel.

CREATE TABLE "roler"
(
    rolerId  BIGSERIAL,
    roleType VARCHAR(5),
    CONSTRAINT roler_key PRIMARY KEY (rolerId)
);

INSERT INTO public.roler (roleType)
VALUES ('ADMIN');

INSERT INTO public.roler (roleType)
VALUES ('USER');

SELECT *
FROM public.roler;

SELECT rolerId, roleType
FROM public.roler
WHERE roleType = 'USER';

-- Tabela papel usuário.
CREATE TABLE "user_roler"
(
    userIdFk  BIGINT NOT NULL,
    rolerIdFk BIGINT NOT NULL,
    CONSTRAINT fk_user_userId FOREIGN KEY (userIdFk)
        REFERENCES public."user" (userId) ON DELETE CASCADE,
    CONSTRAINT fk_roler_rolerID FOREIGN KEY (rolerIdFk)
        REFERENCES public.roler (rolerId) ON DELETE CASCADE
);

SELECT *
FROM public.user_roler;

-- Tabela dos livros.

DROP TABLE book_dtls;

CREATE TABLE "book_dtls"
(
    bookID       BIGSERIAL,
    bookName     VARCHAR      NOT NULL,
    author       VARCHAR(100) NOT NULL,
    price        VARCHAR(6)   NOT NULL,
    bookCategory VARCHAR(10)  NOT NULL,
    status       VARCHAR(10)  NOT NULL,
    photo        VARCHAR,
    email        VARCHAR,
    CONSTRAINT book_key PRIMARY KEY (bookID)
);

SELECT *
FROM public.book_dtls;

SELECT *
FROM public.book_dtls
WHERE bookid = 7;

ALTER TABLE book_dtls
    ALTER COLUMN status TYPE VARCHAR(15);

ALTER TABLE book_dtls
    ALTER COLUMN bookCategory TYPE VARCHAR(15);

-- Vendo o enconding do banco.
SELECT datname, pg_encoding_to_char(encoding)
FROM pg_database;

-- Tabela carrinho de compras:

CREATE TABLE "cart"
(
    cartId    BIGSERIAL,
    bookIdFK  BIGINT  NOT NULL,
    userIdFk  BIGINT  NOT NULL,
    book_name VARCHAR NOT NULL,
    author    VARCHAR NOT NULL,
    price     VARCHAR NOT NULL,
    CONSTRAINT cart_id PRIMARY KEY (cartId),
    CONSTRAINT fk_book_bookId FOREIGN KEY (bookIdFK) REFERENCES public.book_dtls (bookid) ON DELETE CASCADE,
    CONSTRAINT fk_user_userId FOREIGN KEY (userIdFk) REFERENCES public."user" (userid) ON DELETE CASCADE
);

SELECT * FROM public.cart;

SELECT * FROM public.cart WHERE useridfk = 1;