USE [master]
GO
/****** Object:  Database [dbpeliculas]    Script Date: 11/03/2020 5:31:34 p. m. ******/
CREATE DATABASE [dbpeliculas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbpeliculas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.EQUIPO\MSSQL\DATA\dbpeliculas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbpeliculas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.EQUIPO\MSSQL\DATA\dbpeliculas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [dbpeliculas] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbpeliculas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbpeliculas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbpeliculas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbpeliculas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbpeliculas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbpeliculas] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbpeliculas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbpeliculas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbpeliculas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbpeliculas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbpeliculas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbpeliculas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbpeliculas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbpeliculas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbpeliculas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbpeliculas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbpeliculas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbpeliculas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbpeliculas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbpeliculas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbpeliculas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbpeliculas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbpeliculas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbpeliculas] SET RECOVERY FULL 
GO
ALTER DATABASE [dbpeliculas] SET  MULTI_USER 
GO
ALTER DATABASE [dbpeliculas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbpeliculas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbpeliculas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbpeliculas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbpeliculas] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbpeliculas', N'ON'
GO
ALTER DATABASE [dbpeliculas] SET QUERY_STORE = OFF
GO
USE [dbpeliculas]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[idCategoria] [smallint] NOT NULL,
	[descripcion] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ciudad]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ciudad](
	[codCiudad] [smallint] NOT NULL,
	[nombre] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[idCliente] [smallint] NOT NULL,
	[nombre] [varchar](15) NULL,
	[direccion] [varchar](20) NULL,
	[codCiudad] [smallint] NULL,
	[email] [varchar](20) NULL,
	[nombreDeUsuario] [varchar](10) NULL,
	[contrasena] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[entidad]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entidad](
	[idEntidad] [smallint] NOT NULL,
	[nombre] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idEntidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[factura]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factura](
	[nroFactura] [smallint] NOT NULL,
	[fecha] [date] NOT NULL,
	[noTarjeta] [numeric](18, 0) NOT NULL,
	[tipoTarjeta] [char](7) NULL,
	[noAprobacion] [numeric](6, 0) NOT NULL,
	[idEntidad] [smallint] NOT NULL,
	[nroOrden] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nroFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orden]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orden](
	[nroOrden] [smallint] NOT NULL,
	[idCliente] [smallint] NOT NULL,
	[fecha] [date] NOT NULL,
	[estado] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[nroOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto](
	[idProducto] [smallint] NOT NULL,
	[idCategoria] [smallint] NOT NULL,
	[nombre] [varchar](15) NULL,
	[descripcion] [varchar](30) NULL,
	[noPiezas] [smallint] NULL,
	[pesoKg] [numeric](3, 1) NULL,
	[precio] [numeric](12, 0) NULL,
	[cantidadDisp] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productosOrden]    Script Date: 11/03/2020 5:31:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productosOrden](
	[nroOrden] [smallint] NOT NULL,
	[idProducto] [smallint] NOT NULL,
	[cantidad] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[nroOrden] ASC,
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[producto] ADD  DEFAULT ((1)) FOR [noPiezas]
GO
ALTER TABLE [dbo].[cliente]  WITH CHECK ADD FOREIGN KEY([codCiudad])
REFERENCES [dbo].[ciudad] ([codCiudad])
GO
ALTER TABLE [dbo].[factura]  WITH CHECK ADD FOREIGN KEY([idEntidad])
REFERENCES [dbo].[entidad] ([idEntidad])
GO
ALTER TABLE [dbo].[factura]  WITH CHECK ADD FOREIGN KEY([nroOrden])
REFERENCES [dbo].[orden] ([nroOrden])
GO
ALTER TABLE [dbo].[orden]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[cliente] ([idCliente])
GO
ALTER TABLE [dbo].[productosOrden]  WITH CHECK ADD FOREIGN KEY([idProducto])
REFERENCES [dbo].[producto] ([idProducto])
GO
ALTER TABLE [dbo].[productosOrden]  WITH CHECK ADD FOREIGN KEY([nroOrden])
REFERENCES [dbo].[orden] ([nroOrden])
GO
ALTER TABLE [dbo].[factura]  WITH CHECK ADD CHECK  (([tipoTarjeta]='DEBITO' OR [tipoTarjeta]='CREDITO'))
GO
ALTER TABLE [dbo].[orden]  WITH CHECK ADD CHECK  (([estado]='Cancelada' OR [estado]='Finalizada' OR [estado]='ParaEnvio' OR [estado]='Facturada' OR [estado]='EnProceso'))
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD CHECK  (([cantidadDisp]>(0)))
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD CHECK  (([pesoKg]>(0)))
GO
ALTER TABLE [dbo].[producto]  WITH CHECK ADD CHECK  (([precio]>(0)))
GO
USE [master]
GO
ALTER DATABASE [dbpeliculas] SET  READ_WRITE 
GO
