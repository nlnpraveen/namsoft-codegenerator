using System;
using System.Collections.Generic;
using System.Data.EntityClient;
using System.Data.Objects;
using System.Linq;
using System.Text;

namespace PSODPOCO
{
  //these are the hand created classes, not code generated

  public class Room
  {
    public Room()
    {
      Talks = new List<Talk>();
    }
    public int RoomId { get; set; }
    public String RoomNumber { get; set; }
    public ICollection<Talk> Talks { get; private set; }
    
  }

  public class Talk
  {
    public Talk()
    {
 
    }
    public virtual int Id { get; set; }
    public virtual string Name { get; set; }
    public virtual int RoomId { get; set; }
    public virtual ICollection<Speaker> Speakers { get; set; }
    public virtual Room Room { get; set; }
    public virtual DateTime TalkTime { get; set; }
     //more logic can be added
  }

  public class Speaker
  {
    public Speaker()
    {
      Talks = new List<Talk>();
    }
    public int Id { get; set; }
    public string Name { get; set; }
    public ICollection<Talk> Talks { get; private set; }
    //more logic can be added
  }

  public class ConferenceEntities : ObjectContext
  {
    public ConferenceEntities(): base("name=ConferenceEntities")
    {
      ContextOptions.LazyLoadingEnabled = true;
    }
    public ObjectSet<Room> Rooms
    {
      get { return CreateObjectSet<Room>(); }
    }
    public ObjectSet<Talk> Talks
    {
      get { return CreateObjectSet<Talk>(); }
    }
    public ObjectSet<Speaker> Speakers
    {
      get { return CreateObjectSet<Speaker>(); }
    }
  }
}
