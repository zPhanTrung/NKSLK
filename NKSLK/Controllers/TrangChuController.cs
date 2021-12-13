using NKSLK.Dao;
using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class TrangChuController : Controller
    {
        public ActionResult Index()
        {
            return RedirectPermanent("/CongNhan");
        }
    }
}