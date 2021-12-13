using NKSLK.Dao;
using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class ThongKeController : Controller
    {
        QLNC db = new QLNC();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LuongSanPham(FormCollection collection)
        {
            ViewBag.LuaChon = collection["luachon"];
            ViewBag.NgayBatDau_1 = collection["ngaybatdau-search-1"];
            ViewBag.NgayKetThuc_1 = collection["ngayketthuc-search-1"];
            var model = ThongKeDao.LuongSanPham(collection, db);
            return View(model);
        }

        public ActionResult NgayCongDiLam(FormCollection collection)
        {
            ViewBag.LuaChon = collection["luachon"];
            ViewBag.MaCN = collection["macn-search"];
            ViewBag.NgayBatDau_2 = collection["ngaybatdau-search-2"];
            ViewBag.NgayKetThuc_2 = collection["ngayketthuc-search-2"];
            var model = ThongKeDao.NgayCongDiLam(collection, db);
            return View(model);
        }

    }
}