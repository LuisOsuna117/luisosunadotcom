import PropTypes from 'prop-types';

function Item(props) {
    const { img, title, dates, desc } = props
    return (
        <div className="flex flex-col sm:flex-row items-center w-11/12 2xl:w-2/4 py-2">
            <img className="h-20 w-20 rounded" src={img} alt="" />
            <div className="w-full flex flex-col px-4">
                <div className="font-bold">{title}</div>
                <div className="font-light text-gray-600">{dates}</div>
                <div className="text-sm text-justify">{desc}</div>
            </div>
        </div>
    );
}

Item.propTypes = {
    img: PropTypes.string.isRequired,
    title: PropTypes.string.isRequired,
    dates: PropTypes.string.isRequired,
    desc: PropTypes.string.isRequired,
};

export default Item;