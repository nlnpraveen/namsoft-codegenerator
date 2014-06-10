using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TrainingCompany.Controllers
{
    public class CoursesController : ApiController
    {
        public IEnumerable<course> Get()
        {
            return courses;
        }
        public HttpResponseMessage Post([FromBody]course c)
        {
            c.id = courses.Count;
            courses.Add(c);
            //i should return a 201 with a location header
            var msg = Request.CreateResponse(
                HttpStatusCode.Created);
            msg.Headers.Location = 
                new Uri(Request.RequestUri + c.id.ToString());
            return msg;


        }
        public void Put(int id, [FromBody]course course)
        {
            var ret = (from c in courses
                       where c.id == id
                       select c).FirstOrDefault();
            ret.label = course.label;

          
        }
        public void Delete(int id)
        {
            var ret = (from c in courses
                       where c.id == id
                       select c).FirstOrDefault();
            courses.Remove(ret);
        }
        public HttpResponseMessage Get(int id)
        {
            HttpResponseMessage msg = null;
            var ret = (from c in courses
                       where c.id == id
                       select c).FirstOrDefault();
            //if null  - I should return a 404
            if (ret == null)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Course not found!");

            }
            else
            {
                msg = Request.CreateResponse<course>(HttpStatusCode.OK, ret);
            }
            return msg;
        }
        public IEnumerable<course> Get(string term)
        {
            var ret = (from c in courses
                       where c.label.ToLower().Contains(term.ToLower())
                       select c);
            return ret;
        }

        static List<course> courses = InitCourses();

        private static List<course> InitCourses()
        {
            var ret = new List<course>();
            ret.Add(new course { id = 0, label = "Web API" });
            ret.Add(new course { id = 1, label = "Mobile Apps with HTML5" });
            return ret;
        }
    }
    public class course
    {
        public int id;
        public string label;
    }
}
