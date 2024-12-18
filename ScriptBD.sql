USE [CasoEstudioKN]
GO
/****** Object:  Table [dbo].[CasasSistema]    Script Date: 10/12/2024 10:47:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CasasSistema](
	[IdCasa] [bigint] IDENTITY(1,1) NOT NULL,
	[DescripcionCasa] [varchar](30) NULL,
	[PrecioCasa] [decimal](10, 2) NOT NULL,
	[UsuarioAlquiler] [varchar](30) NULL,
	[FechaAlquiler] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CasasSistema] ON 

INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (3, N'Casa amplia en San José', CAST(180000.00 AS Decimal(10, 2)), N'Juanito Pérez', CAST(N'2024-12-10' AS Date))
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (4, N'Casa en Puntarenas', CAST(250000.00 AS Decimal(10, 2)), N'Ricardo Vargas', CAST(N'2024-12-10' AS Date))
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (5, N'Casa moderna en Alajuela', CAST(200000.00 AS Decimal(10, 2)), NULL, NULL)
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (6, N'Casa colonial en Cartago', CAST(175000.00 AS Decimal(10, 2)), NULL, NULL)
INSERT [dbo].[CasasSistema] ([IdCasa], [DescripcionCasa], [PrecioCasa], [UsuarioAlquiler], [FechaAlquiler]) VALUES (7, N'Casa con jardín en Heredia', CAST(195000.00 AS Decimal(10, 2)), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CasasSistema] OFF
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCasas]    Script Date: 10/12/2024 10:47:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures


CREATE PROCEDURE [dbo].[ConsultarCasas]
AS
BEGIN
    SELECT 
        DescripcionCasa, 
        PrecioCasa, 
        UsuarioAlquiler, 
        CASE 
            WHEN UsuarioAlquiler IS NULL THEN 'Disponible' 
            ELSE 'Reservada' 
        END AS Estado,
        FORMAT(FechaAlquiler, 'dd/MM/yyyy') AS FechaAlquiler
    FROM CasasSistema
    WHERE PrecioCasa BETWEEN 115000 AND 180000
    ORDER BY Estado ASC;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarCasasDisponibles]    Script Date: 10/12/2024 10:47:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ConsultarCasasDisponibles]
AS
BEGIN
    SELECT IdCasa, DescripcionCasa
    FROM CasasSistema
    WHERE UsuarioAlquiler IS NULL
      AND FechaAlquiler IS NULL;
END;
GO
/****** Object:  StoredProcedure [dbo].[ConsultarPrecioCasaPorId]    Script Date: 10/12/2024 10:47:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ConsultarPrecioCasaPorId]
    @pIdCasa BIGINT
AS
BEGIN
    SELECT PrecioCasa
    FROM CasasSistema
    WHERE IdCasa = @pIdCasa;
END;
GO
/****** Object:  StoredProcedure [dbo].[Reserva]    Script Date: 10/12/2024 10:47:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reserva]
    @pIdCasa BIGINT, 
    @pUsuarioAlquiler varchar(30)
AS
BEGIN
    UPDATE CasasSistema
    SET UsuarioAlquiler = @pUsuarioAlquiler,
        FechaAlquiler = GETDATE()
    WHERE IdCasa = @pIdCasa;
END;
GO
