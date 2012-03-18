using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SaiVision.Platform.Common.Extensions
{
    public static class IEnumerableExtensions
    {
        public static void ForEach<T>(this IEnumerable<T> source, Action<T> action)
        {
            foreach (T element in source)
                action(element);
        }
    }
}
