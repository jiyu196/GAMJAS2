package service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import domain.Station;
import lombok.extern.slf4j.Slf4j;
import mapper.StationMapper;
import util.APIUtil;
import util.MybatisUtil;

@Slf4j
public class StationService {
	
	int pageSize = 100;
	int startPage = 1;
	
	private static final Map<String, String> LINECOLOR_MAP = Map.ofEntries(
		    Map.entry("1호선", "#0052A4"),
		    Map.entry("2호선", "#009D3E"),
		    Map.entry("3호선", "#EF7C1C"),
		    Map.entry("4호선", "#00A5DE"),
		    Map.entry("5호선", "#996CAC"),
		    Map.entry("6호선", "#CD7C2F"),
		    Map.entry("7호선", "#747F00"),
		    Map.entry("8호선", "#E6186C"),
		    Map.entry("9호선", "#BDB092")
		);
	
	public List<Station> getList() throws IOException {
		List<Station> list = new ArrayList<>();
		
		while(true) {
			int endPage = pageSize + startPage - 1;
			
			String page = startPage + "/" + endPage;
			
			String urlStr = new APIUtil().getOpenAPIURL(Station.class, "/json/subwayStationMaster/", page);
		
			URL url = new URL(urlStr);
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setRequestMethod("GET");
			
			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
			
			StringBuilder sb = new StringBuilder();
			String line ;
			
			while((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			log.info(sb.toString());
			JsonObject jobj = JsonParser.parseString(sb.toString()).getAsJsonObject();
			JsonArray rows = jobj.getAsJsonObject("subwayStationMaster").getAsJsonArray("row");
			
			Gson gson = new GsonBuilder().create();
			
			Station[] arr = gson.fromJson(rows, Station[].class);
			 
			log.info("arrlength :: {}", arr.length);
			log.info("gson 객체를 배열로 담은 것");
			
			list.addAll(Arrays.asList(arr));
			log.info("배열을 list로 담은 것");
			

			startPage += pageSize;
			if(pageSize > arr.length) {
				break;
			}
		}
			return list;
		
		}
		
		public void register(Station station) {
			try(SqlSession session = MybatisUtil.getSqlSession()){
				StationMapper mapper = session.getMapper(StationMapper.class);
				mapper.insert(station);
				session.commit();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public List<Station> getLineStations(String lineName) {
			
			try (SqlSession session = MybatisUtil.getSqlSession()) {
				StationMapper mapper = session.getMapper(StationMapper.class);
				List<Station> list = mapper.selectByLine(lineName); 
				
				if(list == null) {
					System.out.println("역 데이터가 없음. lineName = " + lineName);
					return new ArrayList<>();
				}
				String lineColor = LINECOLOR_MAP.getOrDefault(lineName, "#999999");
				for(Station station : list) {
					station.setLineColor(lineColor);
				}
				
				if("2호선".equals(lineName) && !list.isEmpty()) {
					list.add(list.get(0));	//2호선만
				}
				
		            System.out.println("조회된 역 개수: " + list.size());
		            return list;
			}
			catch(Exception e) {
				e.printStackTrace();
				return new ArrayList<>();
			}
		}

			
	}
		
		
