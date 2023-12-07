CREATE SCHEMA "ebook-app";

-- Tabela do usuário.

CREATE TABLE "ebook-app".user
(
    userId   BIGSERIAL,
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR      NOT NULL UNIQUE,
    phno     VARCHAR(11)  NOT NULL,
    password VARCHAR      NOT NULL,
    CONSTRAINT userKey PRIMARY KEY (userId)
);

SELECT *
FROM "ebook-app".user;

-- Tabela papel.

CREATE TABLE "ebook-app".roler
(
    rolerId  BIGSERIAL,
    roleType VARCHAR(5),
    CONSTRAINT roler_key PRIMARY KEY (rolerId)
);

INSERT INTO "ebook-app".roler (roleType)
VALUES ('ADMIN');

INSERT INTO "ebook-app".roler (roleType)
VALUES ('USER');

SELECT *
FROM "ebook-app".roler;

SELECT rolerId, roleType
FROM "ebook-app".roler
WHERE roleType = 'USER';

-- Tabela papel usuário.
CREATE TABLE "ebook-app".user_roler
(
    userIdFk  BIGINT NOT NULL,
    rolerIdFk BIGINT NOT NULL,
    CONSTRAINT fk_user_userId FOREIGN KEY (userIdFk)
        REFERENCES "ebook-app".user (userId) ON DELETE CASCADE,
    CONSTRAINT fk_roler_rolerID FOREIGN KEY (rolerIdFk)
        REFERENCES "ebook-app".roler (rolerId) ON DELETE CASCADE
);

SELECT *
FROM "ebook-app".user_roler;

-- Tabela dos livros.

CREATE TABLE "ebook-app".book_dtls
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

ALTER TABLE "ebook-app".book_dtls
    ALTER COLUMN price TYPE NUMERIC(5, 2) USING price::numeric(5, 2);

SELECT *
FROM "ebook-app".book_dtls;

ALTER TABLE "ebook-app".book_dtls
    ALTER COLUMN status TYPE VARCHAR(15);

ALTER TABLE "ebook-app".book_dtls
    ALTER COLUMN bookCategory TYPE VARCHAR(15);


-- Tabela carrinho de compras:

CREATE TABLE "ebook-app".cart
(
    cartId    BIGSERIAL,
    bookIdFK  BIGINT  NOT NULL,
    userIdFk  BIGINT  NOT NULL,
    book_name VARCHAR NOT NULL,
    author    VARCHAR NOT NULL,
    price     VARCHAR NOT NULL,
    CONSTRAINT cart_id PRIMARY KEY (cartId),
    CONSTRAINT fk_book_bookId FOREIGN KEY (bookIdFK) REFERENCES "ebook-app".book_dtls (bookid) ON DELETE CASCADE,
    CONSTRAINT fk_user_userId FOREIGN KEY (userIdFk) REFERENCES "ebook-app".user (userid) ON DELETE CASCADE
);

ALTER TABLE "ebook-app".cart
    ALTER COLUMN price TYPE NUMERIC(5, 2) USING price::numeric(5, 2);


-- Vendo o enconding do banco.
SELECT datname, pg_encoding_to_char(encoding)
FROM pg_database;