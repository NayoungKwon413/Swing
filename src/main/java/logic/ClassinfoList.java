package logic;

import java.util.List;

public class ClassinfoList {
	private List<Classinfo> classinfos;

	public List<Classinfo> getClassinfos() {
		return classinfos;
	}

	public void setClassinfos(List<Classinfo> classinfos) {
		this.classinfos = classinfos;
	}

	@Override
	public String toString() {
		return "ClassinfoList [classinfos=" + classinfos + "]";
	}
}
