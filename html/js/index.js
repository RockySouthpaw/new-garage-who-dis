document.addEventListener('DOMContentLoaded', function(){

	var splide

	var vehicleClass = {
		0: 'Compacts',
		1: 'Sedans',
		2: 'SUVs',
		3: 'Coupes',
		4: 'Muscle',
		5: 'Sports Classics',
		6: 'Sports',
		7: 'Super',
		8: 'Motorcycles',
		9: 'Off-road',
		10: 'Industrial',
		11: 'Utility',
		12: 'Vans',
		13: 'Cycles',
		14: 'Boats',
		15: 'Helicopters',
		16: 'Planes',
		17: 'Service',
		18: 'Emergency',
		19: 'Military',
		20: 'Commercial',
		21: 'Trains'
	}

	let garageData = [
		{
			'model' : 'Random 1',
			'garage' : 'Pink Cage',
			'class' : 0,
			'plate' : '12A9JKAD',
			'engineState': 'Decent',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Thursday',
			'purchasedMonth' : 'April',
			'purchasedDate' : '2nd',
			'isVehicleImpounded' : true,
			'vehicleImage' : '../img/test3.png'
		},
		

		{
			'model' : 'Random 2',
			'garage' : 'Pink Cage 2',
			'class' : 3,
			'plate' : '5G363AD',
			'engineState': 'Good',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Monday',
			'purchasedMonth' : 'July',
			'purchasedDate' : '15th',
			'isVehicleImpounded' : false,
			'vehicleImage' : '../img/test.png'
		},

		{
			'model' : 'Random 3',
			'garage' : 'Pink Cage',
			'class' : 2,
			'plate' : '56GFS',
			'engineState': 'Decent',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Thursday',
			'purchasedMonth' : 'December',
			'purchasedDate' : '24th',
			'isVehicleImpounded' : true,
			'vehicleImage' : '../img/test2.png'
		},

		{
			'model' : 'Random 4',
			'garage' : 'Pink Cage 2',
			'class' : 5,
			'plate' : '5G363AD',
			'engineState': 'Good',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Monday',
			'purchasedMonth' : 'July',
			'purchasedDate' : '15th',
			'isVehicleImpounded' : false,
			'vehicleImage' : ''
		},
		{
			'model' : 'Random 5',
			'garage' : 'Pink Cage',
			'class' : 1,
			'plate' : '12A9JKAD',
			'engineState': 'Decent',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Thursday',
			'purchasedMonth' : 'April',
			'purchasedDate' : '2nd',
			'isVehicleImpounded' : false,
			'vehicleImage' : '../img/test2.png'
		},

		{
			'model' : 'Random 6',
			'garage' : 'Pink Cage 2',
			'class' : 3,
			'plate' : '5G363AD',
			'engineState': 'Good',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Monday',
			'purchasedMonth' : 'July',
			'purchasedDate' : '15th',
			'isVehicleImpounded' : true,
			'vehicleImage' : '../img/test.png'
		},

		{
			'model' : 'Random 7',
			'garage' : 'Pink Cage 2',
			'class' : 8,
			'plate' : '5G363AD',
			'engineState': 'Good',
			'bodyState': 'Fabulous',
			'purchasedDay' : 'Monday',
			'purchasedMonth' : 'July',
			'purchasedDate' : '15th',
			'isVehicleImpounded' : false,
			'vehicleImage' : '../img/test.png'
		}
	]

	function insertCards(vehicleData){

		if (splide != null){
			destroySlide('splide__slide')
		}
		console.log('Adding slides', vehicleData)
		
		for (i=0; i < vehicleData.length; i++){
			let data = vehicleData[i]
			let impoundString
			let vehicleImage

			if (data.isVehicleImpounded == true){
				impoundString = 'src="../img/impound.png"'
			}
			else{
				impoundString = ''
			}

			if (data.vehicleImage === '' || data.vehicleImage == null || data.vehicleImage.length == 0){
				vehicleImage = "https://i.imgur.com/CHmtRZL.png"
			}
			else{
				vehicleImage = data.vehicleImage
			}

			console.log(data.vehicleImage)
			let splideList = document.createElement('li');
			splideList.classList.add('splide__slide');
			splideList.innerHTML = `
					<div class="container">	
						<img class="vehicle-overlay-image"${impoundString}>
						<img class="vehicle-image" src="${vehicleImage}">

						<div class="vehicle-info-container">
							<div class="vehicle-info-block">
								<span class="info-title">Model</span>
								<span class="info-data">${data.model}</span>
							</div>
							<div class="vehicle-info-block">
								<span class="info-title">Garage</span>
								<span class="info-data">${data.garage}</span>
							</div>
							<div class="vehicle-info-block">
								<span class="info-title">Class</span>
								<span class="info-data">${vehicleClass[data.class]}</span>
							</div>
							<div class="vehicle-info-block">
								<span class="info-title">License Plate</span>
								<span id="data-plate" class="info-data plate">${data.plate}</span>
							</div>
							<div class="vehicle-info-block">
								<span class="info-title">Engine State</span>
								<span class="info-data">${data.engineState}</span>
							</div>
							<div class="vehicle-info-block">
								<span class="info-title">Body State</span>
								<span class="info-data">${data.bodyState}</span>
							</div>
						</div>

						<div class="vehicle-date-container">
							<p>
								Purchased on ${data.purchasedDay}, <br>${data.purchasedMonth} ${data.purchasedDay}
							</p>
						</div>

						<div class="vehicle-btn-container">
							<div class="vehicle-top-container">
								<a class="sell-button">Sell Vehicle</a>
								<a class="photo-button">New Photo</a>
							</div>
							<a class="spawn-button">Spawn Vehicle</a>
						</div>

					</div>`

			let list = document.getElementById('list')
			list.appendChild(splideList)
		}

		// If total vehicles are less than 3 then add fake elements to prevent
		// weird card scrolling  
		if (vehicleData.length < 3){
			console.log('Adding fake cards')
			for (i=0; i<(3-vehicleData.length); i++){
				let splideList = document.createElement('li');
				splideList.classList.add('splide__slide');
				let list = document.getElementById('list')
				list.appendChild(splideList)
			}
		}

		splide = new Splide( '.splide', {
			type   : 'slide',
			perPage: 3,
			perMove: 4,
			focus  : 'center',
			arrows: false
		} );
	
		splide.mount();
	}


	function destroySlide(){
		let elements = document.getElementsByClassName('splide__slide');
		while(elements.length > 0){
			elements[0].parentNode.removeChild(elements[0]);
		}
	}


	function manageClicks(){

		document.getElementById("arrow-left" ).onclick = function() {
			splide.go( '<' );
		}
	
		document.getElementById("arrow-right" ).onclick = function() {
			splide.go( '>' );
		}
	
		document.getElementById("double-arrow-left").onclick = function() {
			splide.go( 0 );
		}
	
		document.getElementById("double-arrow-right").onclick = function() {
			splide.go( splide.length );
		}
	
		let sellButtons = document.getElementsByClassName("sell-button")
		let photoButtons = document.getElementsByClassName("photo-button")
		let spawnButtons = document.getElementsByClassName("spawn-button")

		for (i=0; i< sellButtons.length; i++){
			sellButtons[i].onclick = function(){
				let thisPlateNumber = this.parentElement.parentElement.children[2].children[3].children[1].innerText
				postData('sellVehicle', {plate: thisPlateNumber})
			}
		}

		for (i=0; i< photoButtons.length; i++){
			photoButtons[i].onclick = function(){
				// Add option to take photo
			}
		}

		for (i=0; i< spawnButtons.length; i++){
			spawnButtons[i].onclick = function(){
				
			}
		}
	}

	

	// document.getElementById("data-spawn").onclick = function() {
		
	// }

	// document.getElementById("data-photo").onclick = function() {
		
	// }

	


	function sortGarageData(vehicleClassType){
		if(vehicleClassType != -1){
			let newGarageData = []
			for (i=0; i<garageData.length; i++){
				if(parseInt(garageData[i].class) == vehicleClassType){
					newGarageData.push(garageData[i])
				}
			}
			
			insertCards(newGarageData)
		}
		else{
			insertCards(garageData)
		}
	}

	function getAvailableVehicleTypes(){
		let availableTypes = []
		for(i=0; i<garageData.length; i++){
			availableTypes.push(parseInt(garageData[i].class))
		}
		
		availableTypes = availableTypes.filter( function( item, index, inputArray ) {
			return inputArray.indexOf(item) == index;
		});
		
		return availableTypes
	}


	function createCategory(categoryList){
		// Clear up old html elements if any
		let presentList = document.getElementById("categorySelector")
		if (presentList){
			presentList.parentElement.removeChild(presentList)
		}

		let selectList = document.createElement("select");
		selectList.id = "categorySelector";
		selectList.classList = "arrows";
		document.getElementById("custom-select").appendChild(selectList);

		//Create and append the options
		let selectAll = document.createElement("option")
		selectAll.value = -1
		selectAll.text = "Select Category"
		selectList.appendChild(selectAll);
		for (var i = 0; i < categoryList.length; i++) {
			var option = document.createElement("option");
			option.value = categoryList[i];
			option.text = vehicleClass[categoryList[i]];
			selectList.appendChild(option);
		}
	}


	let availTypes = getAvailableVehicleTypes()
	createCategory(availTypes)
	
	insertCards(garageData)

	manageClicks()

	document.getElementById('categorySelector').onchange = function() {
		console.log('New selected value is: ', this.value, typeof(parseInt(this.value)));
		sortGarageData(parseInt(this.value))
	}
	

	const postData = async (cbname, data) => {
		const options = {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json; charset=UTF-8'
			},
			body: JSON.stringify(data)
		};
		const resp = await fetch(`https://${GetParentResourceName()}/${cbname}`, options);
		return await resp.json();
	}

	function toggleVisibility(toggle){
		if (toggle == true){
			body.style.display = 'flex'
		}
		else if (toggle == false){
			body.style.display = 'none'
		}
	}

	
	window.addEventListener('message', (event) => {
		let data = event.data

		if (data.garageData){
			switch (e.data.action) {
				case 'getVehData':
				case 'display':
					if (e.data.display == true){
						console.log('Toggling visibility true')
						toggleBodyVisibility(true)
					}
					else if (e.data.display == false){
						console.log('Toggling visibility false')
						toggleBodyVisibility(false)
					}
				break;
			}
		}

		if (data.visibility == true){
			toggleVisibility(true)
		}
		else if(data.visibility == false){
			toggleVisibility(false)
		}

    })


})