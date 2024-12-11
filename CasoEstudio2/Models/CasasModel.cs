using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CasoEstudio2.Models
{
    public class CasasModel
    {
        public long IdCasa { get; set; }
        public string DescripcionCasa { get; set; }
        public decimal PrecioCasa { get; set; }
        public string UsuarioAlquiler { get; set; }
        public string EstadoAlquiler { get; set; }
        public string FechaAlquiler { get; set; }
    }
}