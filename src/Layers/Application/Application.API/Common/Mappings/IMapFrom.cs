using AutoMapper;

namespace WebChat.Application.API.Common.Mappings
{
    public interface IMapFrom<TSource>
    {
        void Mapping(Profile profile)
        {
            profile.CreateMap(typeof(TSource), GetType());
        }
    }
}