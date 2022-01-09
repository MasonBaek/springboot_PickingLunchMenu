<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h3>복부인</h3>
<c:choose>
	<c:when test="${checkStoreListBok eq [] || checkStoreListBok eq '[null]'}">
		<div class="nonStore">선택된 식당이 없습니다.</div>
	</c:when>
	<c:otherwise>
		<ul class="chosenStoreList">
			<c:forEach var="chosenStore" items="${checkStoreListBok}">
				<li>
					<dl>
						<dt>이름</dt>
						<dd>${chosenStore.id}</dd>
					</dl>
					<dl>
						<dt>식당</dt>
						<dd>${chosenStore.storePicked}</dd>
					</dl>
				</li>
			</c:forEach>
		</ul>
		
		<div class="pie-chart">
			<canvas id="canvasBok" width="400" height="400"></canvas>
		</div><%--.pie-chart--%>
		
		<script>
			// 파이차트 구현
			checkStoreListBok = [];
      <c:forEach var="chosenStore" items="${checkStoreListBok}">
				checkStoreListBok.push("${chosenStore.storePicked}");
			</c:forEach>

			storeResult = {};
			
      checkStoreListBok.forEach((index) => {
        storeResult[index] = (storeResult[index] || 0)+1;
      });
			
      storeResult = JSON.stringify(storeResult);
      storeResult = storeResult.slice(0, -1);
      storeResult = storeResult.substr(1);
      storeResult = storeResult.split(",");

      choiceCountARR = [];
      choiceStoreARR = [];
      storeResult.forEach((item, index) => {
        let itemArr = item.split(":");
        choiceCountARR.push(Number(itemArr[itemArr.length - 1]));
        choiceStoreARR.push(itemArr[0].slice(0, -1).substr(1));
      });
      
      bgColor = ['#F44336','#29B6F6','#FFEE58','#8D6E63','#FF7043','#FFA726','#263238','#3949AB'];
			
      dataset = {
        label: "식당 선택률",
	      backgroundColor: bgColor,//라벨별 컬러설정
	      data: choiceCountARR
      }
      labels=choiceStoreARR;
      datasets={ datasets:[dataset], labels:labels }
			console.log(dataset);

      config = {
        type: 'pie',
	      data: datasets, //데이터 셋
	      animation:false,
				options: {
          responsive: true,
					maintainAspectRatio: false, //true 하게 되면 캔버스 width,height에 따라 리사이징된다.
					legend: {
            position: 'bottom',
						fontColor: 'black',
						align: 'center',
						display: true,
						fullWidth: true,
						labels: {
              fontColor: 'rgb(0, 0, 0)'
            }
          },
					plugins: {
            labels: [
              {
                render: 'label',
	              fontSize:'15',
                fontStyle: 'bold',
	              position:'outside'
              },
              {
                render: function (args) {
                  return args.value + "표";
                },
                fontSize:'13',
                fontStyle: 'bold',
	              fontColor:'#fff'
                // position:'outside'
              }
            ]
          }
        }
      }

      canvasBok = document.getElementById('canvasBok');
      pieChart = new Chart(canvasBok,config);

		</script>
	</c:otherwise>
</c:choose>
