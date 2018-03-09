class Room extends React.Component {

  constructor(props){
    super(props);
    console.log(this.props)
  }

  componentDidMount(){
    $('.js-slider#'+this.props.room.id_service).slick({
      slide: "#"+this.props.room.id_service+" .u-slide",
      appendArrows: "#" + this.props.room.id_service + ".js-slider",
      arrows: true,
      dots: true,
      infinite: true,
      speed: 600,
      slidesToShow: true,
      autoplay: false,
      adaptiveHeight: true
    })
  }

  defaultNoImage(){
    return(
      <div className="u-slide cf">
        <a href="javascript:void(0)">
          <img src="javascript:void(0)" alt="" height="250px" width='100%'/>
        </a>
      </div>
    )
  }

  listImage(){
    return this.props.room.img_service.map(function(i,e){
      if (e < 4){
        return (
          <div className="u-slide cf">
            <a href="javascript:void(0)">
              <img src={i['large']} alt="" height="250px" width='100%'/>
            </a>
          </div>
        )
      }
    })
  }

  render() {
    let images = null;

    if(this.props.room.img_service.length == 0){
      images = this.defaultNoImage()
    }else{
      images = this.listImage()
    }
    return (
      <article className="u-home-imtes">
        <div className="u-thumbnail">
          <div className="js-slider cf" id={this.props.room.id_service}>
            {images}
          </div>
        </div>
        <div className="u-description cf">
          <a href="#" className="u-link">
            <p className="u-spec">{this.props.room.type_service}</p>
            <h1 className="u-name">{this.props.room.name_service}</h1>
            <div className="u-status cf">
              <p className="u-price">{this.props.room.price_service}/泊</p>
            </div>
          </a>
        </div>
      </article>
    );
  }
}