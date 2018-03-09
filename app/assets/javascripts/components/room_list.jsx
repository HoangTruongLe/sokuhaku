class RoomList extends React.Component {
  constructor(props){
    super(props);
    this.room_ids = this.props.crawl_ids
    this.channel_config = {
      channel: 'HostRoomsChannel',
      uuid: this.props.uuid,
      host: this.props.host
    }
  }

  componentWillMount(){
    if(this.room_ids.length > 0){
      this.generate_channel()
    }
  }

  generate_channel(){
    room_ids = this.room_ids;
    id_current = 0;
    App.HostRooms = App.cable.subscriptions.create(this.channel_config, {
      connected: function(data){
        this.crawler()
      },

      received: function(result){
        if(result.data.type == 'crawler'){
          this.append_crawler(result.data.record)
        }
      },

      crawler: function(){
        if(room_ids.length > 0){
          id_current = room_ids.shift()
          return this.perform("crawler", { room_id: id_current })
        }
      },

      append_crawler: function(record){
        $('.list-rooms').append(record);

        $('.js-slider#'+id_current).slick({
          slide: "#"+id_current+" .u-slide",
          appendArrows: "#" + id_current + ".js-slider",
          arrows: true,
          dots: true,
          infinite: true,
          speed: 600,
          slidesToShow: true,
          autoplay: false,
          adaptiveHeight: true
        })

        this.crawler()
      }
    });
  }
  render(){
    var records = this.props.records.map(function(e, i){
      return <div key={i}> <Room room={e} /> </div>
    })

    return (
      <main role="main">
        <nav aria-label="breadcrumb">
          <ol className="breadcrumb">
            <li className="breadcrumb-item"><a href="#">トップ</a></li>
            <li className="breadcrumb-item active" aria-current="page">所有してる部屋一覧</li>
          </ol>
        </nav>
        <header className="row f-align-items-center mt1 cf">
          <h1 className="col-6 col-md-7 main_title">部屋一覧</h1>
          <div className="col-6 col-md-5 row">
            <a href="_img_dummy/sample.csv" target="_blank" className="col-12 col-md-6 btn btn-custom btn-dark">
              サンプルCSVダウンロード
            </a>
            <button type="button" className="col-12 col-md-6 btn btn-custom btn-raised btn-info" data-toggle="modal" data-target="#csvModal">
              部屋のデータを紐付ける
            </button>
          </div>
        </header>
        <div className="u-list-wrap cf list-rooms">
          { records }
        </div>
      </main>
    )
  }
}