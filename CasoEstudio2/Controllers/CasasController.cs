using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.Mvc;
using CasoEstudio2.Models;

namespace CasoEstudio2.Controllers
{
    public class CasasController : Controller
    {
        [HttpGet]
        public ActionResult ConsultaCasas()
        {
            using (var context = new CasoEstudioKNEntities())
            {
                var datos = context.ConsultarCasas().ToList();
                var casas = new List<CasasModel>();
                foreach (var item in datos)
                {
                    casas.Add(new CasasModel
                    {
                        DescripcionCasa = item.DescripcionCasa,
                        PrecioCasa = item.PrecioCasa,
                        UsuarioAlquiler = item.UsuarioAlquiler,
                        FechaAlquiler = item.FechaAlquiler,
                        EstadoAlquiler = item.UsuarioAlquiler == null ? "Disponible" : "Alquilada"
                    });
                }
                return View(casas);
            }
        }

        [HttpGet]
        public ActionResult AlquilerCasa()
        {
            ObtenerCasasDisponibles();
            return View();
        }
        [HttpPost]
        public ActionResult AlquilerCasa(CasasModel model)
        {
            using (var context = new CasoEstudioKNEntities())
            {
                var respuesta = context.Reserva(model.IdCasa, model.UsuarioAlquiler);
                if (respuesta > 0)
                {
                    return RedirectToAction("ConsultaCasas");
                }
                else
                {
                    ViewBag.Mensaje = "Error al alquilar la casa";
                    ObtenerCasasDisponibles();
                    return View(model);
                }
            }
        }

        [HttpGet]
        public ActionResult ConsultarPrecioCasa(long IdCasa)
        {
            using (var context = new CasoEstudioKNEntities())
            {
                var precio = context.ConsultarPrecioCasaPorId(IdCasa).FirstOrDefault();
                return Json(precio, JsonRequestBehavior.AllowGet);
            }

        }

        private void ObtenerCasasDisponibles()
        {
            using (var context = new CasoEstudioKNEntities())
            {
                var datos = context.ConsultarCasasDisponibles().ToList();
                var casas = new List<SelectListItem>();

                casas.Add(new SelectListItem
                {
                    Text = "Seleccione casa disponible",
                    Value = null,
                    Disabled = true,
                    Selected = true
                });

                foreach (var casa in datos)
                {
                    casas.Add(new SelectListItem
                    {
                        Text = casa.DescripcionCasa,
                        Value = casa.IdCasa.ToString()
                    });
                }

                ViewBag.Casas = casas;
            }
        }


    }
}