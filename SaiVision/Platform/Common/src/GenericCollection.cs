using System;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using System.Runtime.Serialization;
using System.Reflection;

namespace SaiVision.Platform.CommonLibrary
{
    /// <summary>
    /// Holds the collection of objects of type T
    /// </summary>
    /// <typeparam name="T"></typeparam>
    [Serializable()]
    [DataContract()]
    public class GenericCollection<T> : ICollection<T>
    {
        #region Fields
        bool _readOnly;
        [DataMember()]
        protected List<T> genericList;
        #endregion

        #region Constructors
        /// <summary>
        /// Initializes a new instance of the <see cref="GenericCollection&lt;T&gt;"/> class.
        /// </summary>
        public GenericCollection()
        {
            genericList = new List<T>();
        }
        #endregion

        #region Public Properties
        /// <summary>
        /// Gets or sets the <see cref="T"/> at the specified index.
        /// </summary>
        /// <value></value>
        public T this[int index]
        {
            get
            {
                return genericList[index];
            }
            set
            {
                genericList[index] = value;
            }
        }

        private string _SortProperty;
        /// <summary>
        /// The name of the property that is used to sort the results.
        /// </summary>
        public string SortProperty
        {
            get { return this._SortProperty; }
            set { this._SortProperty = value; }
        }

        private SortOrder _SortOrder = SortOrder.Ascending;
        /// <summary>
        /// The order in which the results should be sorted.
        /// </summary>
        public SortOrder SortOrder
        {
            get { return this._SortOrder; }
            set { this._SortOrder = value; }
        }

        /// <summary>
        /// Gets the generic list.
        /// </summary>
        /// <value>The generic list.</value>
        public List<T> DataList
        {
            get
            {
                return genericList;
            }
        }
        #endregion

        #region Private Methods
        /// <summary>
        /// Compares the specified t1.
        /// </summary>
        /// <param name="y1">The t1.</param>
        /// <param name="y2">The t2.</param>
        /// <returns>int</returns>
        private int Compare(T t1, T t2)
        {
            if (_SortProperty == string.Empty)
            {
                throw new Exception("Sort Criteria not specified.  A sort criteria must be specified.");
            }

            PropertyInfo p1 = t1.GetType().GetProperty(_SortProperty);
            PropertyInfo p2 = t2.GetType().GetProperty(_SortProperty);
            MethodInfo m1 = p1.GetGetMethod();
            MethodInfo m2 = p2.GetGetMethod();
            object a = m1.Invoke(t1, null);
            object b = m2.Invoke(t2, null);
            if (a == null)
                return 1;
            if (b == null)
                return -1;

            // Only handles strings, datetime, ints, shorts so far 
            if (a is string)
            {
                if (_SortOrder == SortOrder.Ascending)
                {
                    return string.Compare((string)a, (string)b);
                }
                else
                {
                    return string.Compare((string)b, (string)a);
                }
            }
            else if (a is DateTime)
            {
                if (_SortOrder == SortOrder.Ascending)
                {
                    return DateTime.Compare((DateTime)a, (DateTime)b);
                }
                else
                {
                    return DateTime.Compare((DateTime)b, (DateTime)a);
                }

            }
            else if (a is Decimal)
            {
                if (_SortOrder == SortOrder.Ascending)
                {
                    return Decimal.Compare((Decimal)a, (Decimal)b);
                }
                else
                {
                    return Decimal.Compare((Decimal)b, (Decimal)a);
                }
            }
            else // Int Comparison
            {
                int newA = System.Convert.ToInt32(a);
                int newB = System.Convert.ToInt32(b);

                if (_SortOrder == SortOrder.Ascending)
                {
                    return newA.CompareTo(newB);

                }
                else
                {
                    return newB.CompareTo(newA);
                }
            }
        }
        #endregion

        #region Public Methods
        /// <summary>
        /// Adds the specified obj.
        /// </summary>
        /// <param name="obj">The obj.</param>
        public void Add(T obj)
        {
            genericList.Add(obj);
        }

        /// <summary>
        /// Removes all items from the <see cref="T:System.Collections.Generic.ICollection`1"/>.
        /// </summary>
        /// <exception cref="T:System.NotSupportedException">
        /// The <see cref="T:System.Collections.Generic.ICollection`1"/> is read-only.
        /// </exception>
        public void Clear()
        {
            genericList.Clear();
        }

        /// <summary>
        /// Determines whether [contains] [the specified obj].
        /// </summary>
        /// <param name="obj">The obj.</param>
        /// <returns>
        /// 	<c>true</c> if [contains] [the specified obj]; otherwise, <c>false</c>.
        /// </returns>
        public bool Contains(T obj)
        {
            return genericList.Contains(obj);
        }

        /// <summary>
        /// Copies to.
        /// </summary>
        /// <param name="arrItems">The arr items.</param>
        /// <param name="pos">The pos.</param>
        public void CopyTo(T[] arrItems, int pos)
        {
            genericList.CopyTo(arrItems, pos);
        }

        /// <summary>
        /// Removes the specified obj.
        /// </summary>
        /// <param name="obj">The obj.</param>
        /// <returns></returns>
        public bool Remove(T obj)
        {
            return genericList.Remove(obj);
        }

        /// <summary>
        /// Gets the number of elements contained in the <see cref="T:System.Collections.Generic.ICollection`1"/>.
        /// </summary>
        /// <value></value>
        /// <returns>
        /// The number of elements contained in the <see cref="T:System.Collections.Generic.ICollection`1"/>.
        /// </returns>
        public int Count
        {
            get
            {
                return genericList.Count;
            }
        }

        /// <summary>
        /// Gets a value indicating whether the <see cref="T:System.Collections.Generic.ICollection`1"/> is read-only.
        /// </summary>
        /// <value></value>
        /// <returns>true if the <see cref="T:System.Collections.Generic.ICollection`1"/> is read-only; otherwise, false.
        /// </returns>
        public bool IsReadOnly
        {
            get
            {
                return _readOnly;
            }
            set
            {
                _readOnly = value;
            }
        }

        /// <summary>
        /// Returns an enumerator that iterates through a collection.
        /// </summary>
        /// <returns>
        /// An <see cref="T:System.Collections.IEnumerator"/> object that can be used to iterate through the collection.
        /// </returns>
        IEnumerator IEnumerable.GetEnumerator()
        {
            return (IEnumerator)genericList.GetEnumerator();

        }

        /// <summary>
        /// Returns an enumerator that iterates through the collection.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.Collections.Generic.IEnumerator`1"/> that can be used to iterate through the collection.
        /// </returns>
        public IEnumerator<T> GetEnumerator()
        {

            IEnumerator<T> iterator;
            iterator = genericList.GetEnumerator();
            while (iterator.MoveNext())
            {
                yield return iterator.Current;
            }

        }

        /// <summary>
        /// Finds the specified predicate.
        /// </summary>
        /// <param name="predicate">The predicate.</param>
        /// <returns></returns>
        public T Find(Predicate<T> predicate)
        {
            return genericList.Find(predicate);
        }

        /// <summary>
        /// Finds all the instances in this collection that satisfy
        /// the given condition.
        /// </summary>
        /// <param name="predicate">The predicate.</param>
        /// <returns></returns>
        public List<T> FindAll(Predicate<T> predicate)
        {
            return genericList.FindAll(predicate);
        }

        /// <summary>
        /// Sorts the specified sort property.
        /// </summary>
        /// <param name="sortProperty">The sort property.</param>
        /// <param name="sortOrder">The sort order.</param>
        public void Sort(string sortProperty, SortOrder sortOrder)
        {
            this.SortProperty = sortProperty;
            this.SortOrder = sortOrder;
            genericList.Sort(this.Compare);
        }
        #endregion
    }
}
