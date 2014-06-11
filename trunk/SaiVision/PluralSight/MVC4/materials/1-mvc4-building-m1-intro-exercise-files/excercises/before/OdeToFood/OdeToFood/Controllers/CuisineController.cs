using OdeToFood.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OdeToFood.Controllers
{
    //[Authorize]
    //[Log]
    public class CuisineController : Controller
    {
        public ActionResult Index()
        {
            return Content("Index Action");
        }
        
        public ActionResult Search(string name = "french")
        {
            //throw new Exception("Something terrible has happened");

            var message = Server.HtmlEncode(name);
            return Content(message);
            //Other types
            //return RedirectToAction("Index", "Home", new { name = name });
            //return RedirectToRoute("Default", new { controller = "Home", action = "About" });
            //return File(Server.MapPath("~/Content/Site.css"), "text/css");
            //return Json(new { Message = message, Name = "Scott" }, JsonRequestBehavior.AllowGet);
        }       
    }
}
