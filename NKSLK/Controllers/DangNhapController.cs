using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class DangNhapController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            return View("Login");
        }

        public ActionResult CheckLogin(string username, string password)
        {
            QLNC db = new QLNC();
            var rs = db.TAIKHOANs.Find(username);
            if (rs != null)
                if (rs.MatKhau == password)
                    return RedirectPermanent("/Home/Index");
            return View("Login");
        }
    }
}